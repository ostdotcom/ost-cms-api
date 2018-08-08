module DbService
  class Base

    def initialize(params)
      params.delete("controller")
      params.delete("action")
      params = clean(params)
      @params = params
    end

    def clean(params)
      params.each do |key, value|
        if value.is_a? String
        params[key] = params[key].strip
        end
      end
    end

    def validate
      config= YAML.load_file('config/api_config.yml')
      error_object = {}
      @params.each do |param, value|
        if config["meta"][param.to_sym].present?
          field_config = config["meta"][param.to_sym]
          error_object[param] = apply_validations(field_config[:validations], field_config[:data_kind], value)
        end
      end
      is_validated (error_object)
    end


    def is_validated(error_object)
      is_error = false
      error_object.each do |key, value|
        if value.length > 0
          is_error = true
          break
        end
      end
      if is_error
        Result::Base.error(
            {
                error: 'validations_error',
                error_message: 'validations_error',
                error_data: error_object,
                error_action: GlobalConstant::ErrorAction.default,
                error_display_text: 'Validation Errors',
                display_text: 'Validation Errors',
                error_display_heading: 'Error',
                data: {}
            }
        )
      else
        Result::Base.success({})
      end



    end

    def apply_validations(validations, data_type, input)
      error_list = []
      validations.each do |key, validation|
        error = public_send(key, validation, input )
        if error
          error_list.push({key => error })
        end
      end
      data_type_error = public_send(data_type, input)
      if data_type_error
          error_list.push({'data_type' => data_type_error})
      end
      error_list
    end


    def required(validation, input)
      error_msg = "This field is required"
      if validation && input.empty?
        error_msg
      end
    end


    def minlength(validation, input)
      error_msg = "This field mush have minimum of "+ validation.to_s + " length"
      if validation && input.length < validation && input.length != 0
         error_msg
      end
    end

    def maxlength(validation, input)
      error_msg = "This field must have maximum of "+ validation.to_s + " length"
      if validation && input.length > validation
         error_msg
      end
    end



    def text(input)
    end

    def url(input)
      pattern = /\A#{URI::regexp}\z/
      validated = input =~ pattern
      if validated == nil
        "Please enter valid URL"
      end

    end


    def date(input)
      pattern = /\d{4}-\d{1,2}-\d{1,2}$/
      validated = input =~ pattern
      if validated == nil
        "Date format is not valid"
      end

    end


  end
end