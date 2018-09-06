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

    def create_preview_url
      base_preview_url + '&ps=' + generate_preview_signature.to_s
    end

    def base_preview_url
      @base_preview_url ||= GlobalConstant::OstWeb.url + @path + '?ts=' + Time.now.to_i.to_s
    end

    def generate_preview_signature
      Sha256.new({string: base_preview_url, salt: GlobalConstant::OstWeb.sha256_salt}).perform
    end

  end

end
