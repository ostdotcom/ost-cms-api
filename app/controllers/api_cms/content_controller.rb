module ApiCms
  class ContentController < ApiCms::MainController
    before_action :user_auth

    def read_yml_config
      response = success_with_data(GlobalConstant::ApiConfig.fetch_config)
      render_api_response(response)
    end

    def create_data
      service_response = DbService::Create.new(params, @current_user).perform
      render_api_response(service_response)
    end

    def edit_data
      service_response = DbService::Edit.new(params, @current_user).perform
      render_api_response(service_response)
    end


    def delete_data
      service_response = DbService::Delete.new(params, @current_user).perform
      render_api_response(service_response)
    end

    def publish_data
      service_response = DbService::Publish.new(params, @current_user).perform
      render_api_response(service_response)
    end

    def get_active_data
      service_response = DbService::Get.new(params).get_active
      render_api_response(service_response)
    end

    def get_record
      service_response = DbService::Get.new(params).get_record
      render_api_response(service_response)
    end

    def sort_data
      service_response = DbService::Sort.new(params, @current_user).perform
      render_api_response(service_response)
    end

    def rollback_publish
      service_response = DbService::Rollback.new(params, @current_user).perform
      render_api_response(service_response)
    end

  end
end