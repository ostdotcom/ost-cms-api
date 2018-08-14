module DbService
  class Base

    include ::Util::ResultHelper

    def initialize(params, current_user=nil)
      params.delete("controller")
      params.delete("action")
      params = clean(params)
      @params = params
      @user_id = current_user.present? ? current_user.id : 0
    end

    def clean(params)
      params.each do |key, value|
        if value.is_a? String
          params[key] = params[key].strip
        end
      end
    end

    def validate
      config= GlobalConstant::ApiConfig.fetch_config
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
        return error_with_data(
            'validations_error',
            'Validation Errors',
            'Validation Errors',
              GlobalConstant::ErrorAction.default,
            {},
             error_object,
            GlobalConstant::ErrorCode.bad_request
        )
      else
        return success
      end
    end

    def apply_validations(validations, data_type, input)
      error_list = []
      validations.each do |key, validation|
        error = public_send(key, validation, input )
        error_list.push({key => error }) if error
      end
      data_type_error = public_send(data_type, input)
      error_list.push({'data_type' => data_type_error}) if data_type_error
      return error_list
    end

    def required(validation, input)
      if validation && input.empty?
        return "This field is required"
      end
    end

    def minlength(validation, input)
      if validation && input.length < validation && input.length != 0
        return "This field must have minimum "+ validation.to_s + " characters"
      end
    end

    def maxlength(validation, input)
      if validation && input.length > validation
        return "This field must have maximum "+ validation.to_s + " characters"
      end
    end

    def text(input)
    end

    def url(input)
      pattern = /\A#{URI::regexp}\z/
      if (input =~ pattern) == nil
        return "Please enter valid URL"
      end
    end

    def date(input)
      pattern = /\d{4}-\d{1,2}-\d{1,2}$/
      if (input =~ pattern) == nil
        return "Date format is not valid"
      end
    end

  end
end