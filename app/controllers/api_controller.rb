class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :user_auth

  include ::Util::ResultHelper

  def user_profile
    if user_signed_in?
      response = success_with_data(current_user.attributes)
    else
      response = error_with_data(
          'user_not_authenticated',
          'User is not authenticated',
          '',
          GlobalConstant::ErrorAction.default,
          {},
          error_object,
          GlobalConstant::ErrorCode.unauthorized_access
      )
    end
    render_api_response(response)
  end


  def read_yml_config
    config_yaml = YAML.load_file('config/api_config.yml')
    response = success_with_data(config_yaml)
    render_api_response(response)
  end

  def create_data
    service_response = DbService::Create.new(params).perform
    render_api_response(service_response)
  end

  def edit_data
    service_response = DbService::Edit.new(params).perform
    render_api_response(service_response)
  end


  def delete_data
    service_response = DbService::Delete.new(params).perform
    render_api_response(service_response)
  end

  def publish_data
    service_response = DbService::Publish.new(params).perform
    render_api_response(service_response)
  end


  def get_published_data
    service_response = DbService::Get.new(params).get_published
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
    service_response = DbService::Sort.new(params).perform
    render_api_response(service_response)
  end

  def user_auth
    if !user_signed_in?
      r = error_with_data(

              'user_not_authenticated',
              'User is not authenticated',
               '',
               GlobalConstant::ErrorAction.default,
               {},
              {},
              GlobalConstant::ErrorCode.unauthorized_access
      )
      render_api_response(r)
    end
  end
end