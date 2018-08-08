class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :user_auth

  def user_profile
    if user_signed_in?
      user = {
          success: true,
          data: current_user
      }
    else
      user = {
          success: false,
          err: {
              code: 'auth_error'
          }
      }
    end

    render json: user.to_json
  end


  def read_yml_config
    config_yaml = YAML.load_file('config/api_config.yml')
    config = {
        success: true,
        data: config_yaml
    }
    render json: config.to_json
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

  def user_auth
    if !user_signed_in?
      r = Result::Base.error(
          {
              error: 'user_not_authenticated',
              error_message: 'User is not authenticated',
              error_data: {},
              error_action: GlobalConstant::ErrorAction.default,
              error_display_text: 'User is not authenticated.',
              error_display_heading: 'Error',
              data: {}
          }
      )
      render_api_response(r)
    end
  end
end