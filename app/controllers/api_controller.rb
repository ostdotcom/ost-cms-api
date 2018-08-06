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
    puts "I am in entity data"
    render json: status.to_json
  end


  def create_data

  end

end