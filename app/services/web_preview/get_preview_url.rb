module WebPreview

  class GetPreviewUrl

    include ::Util::ResultHelper

    def initialize(params)
      @path = params['path']
    end

    def perform
      success_with_data({url: create_preview_url })
    end

    private

    #
    # Create preview url
    # * Author: Mayur
    # * Date: 3/8/2018
    # * Reviewed by:
    #
    def create_preview_url
      @uri = URI create_raw_preview_url

      preview_token

      add_encoded_signature_to_url
    end

    #
    # create url with original signature
    # * Author: Mayur
    # * Date: 3/8/2018
    # * Reviewed by:
    #
    def create_raw_preview_url
      @raw_url = get_ost_web_url + @path + '?ts=' + Time.now.to_i.to_s + '&ps=' + get_ost_web_salt.to_s
    end

    #
    # Add encoded preview signature to url
    # * Author: Mayur
    # * Date: 3/8/2018
    # * Reviewed by:
    #
    def add_encoded_signature_to_url
      params = Rack::Utils.parse_query @uri.query
      params.delete 'ps'
      @uri.query = params.to_param.blank? ? nil : params.to_param
      @uri.to_s + '&ps=' + @preview_token
    end

    #
    # Returns ost web url
    # * Author: Mayur
    # * Date: 3/8/2018
    # * Reviewed by:
    #
    def get_ost_web_url
      @ost_web_url ||= GlobalConstant::OstWeb.url
    end

    #
    # Returns salt required to create preview signature
    # * Author: Mayur
    # * Date: 3/8/2018
    # * Reviewed by:
    #
    def get_ost_web_salt
      @ost_web_salt ||= GlobalConstant::OstWeb.sha256_salt
    end

    #
    # create preview token
    # * Author: Mayur
    # * Date: 3/8/2018
    # * Reviewed by:
    #
    def preview_token
      @preview_token = Sha256.new({string: @raw_url, salt: GlobalConstant::OstWeb.sha256_salt}).perform
    end

  end

end
