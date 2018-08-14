module ApiRest
  class PublishController < ApiRest::MainController
    def get_published_data
      service_response = DbService::Get.new(params).get_published
      render_api_response(service_response)
    end
  end
end