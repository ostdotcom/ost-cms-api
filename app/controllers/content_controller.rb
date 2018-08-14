class ContentController < ApplicationController
  before_action :user_auth

  def read_yml_config
    config_yaml = YAML.load_file('config/api_config.yml')
    response = success_with_data(config_yaml)
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

end