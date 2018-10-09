module WebPreview

  class GetPreviewUrl

    include ::Util::ResultHelper
    require 'json'


    def initialize(params)
      @path = params['path']
      @previewed_entities =  JSON.parse(params['previewed_entities'])
    end

    def perform
      set_entity_status_to_preview
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


    def set_entity_status_to_preview
      Entity.where(name: @previewed_entities).each do | entity |
        if entity.status == 1
          entity.status = 3
          entity.save
        end
      end
    end

  end

end
