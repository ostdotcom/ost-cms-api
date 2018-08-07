class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

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

  def entity_data
    ValidationHelper::ValidationClass.new.validate({required: true}, "Abcd");
    status = {success: true}
    render json: status.to_json
  end


  def create_data
    status = DbService.create_data_version(request)
    render json: status.to_json
  end

  def edit_data
    status = DbService.edit_data_version(request)
    render json: status.to_json
  end


  def delete_data
    status = DbService.delete_data_version(request)
    render json: status.to_json
  end

  def publish_data
    status = DbService.publish_data(request)
    render json: status.to_json
  end


  def get_published_data
    data = DbService.get_published_data(request)
    render json: data.to_json
  end


  def get_active_data
    data = DbService.get_active(request)
    render json: data.to_json
  end
end