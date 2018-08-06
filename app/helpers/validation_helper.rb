module ValidationHelper
  class ValidationClass
    def validate(fieldName, input)
      fieldName = :news_list_header
      config_yaml = YAML.load_file('config/api_config.yml')
      puts config_yaml["meta"][fieldName][:validations]
      config_yaml
    end

  end
end