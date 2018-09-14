module DbService
  class Base

    include ::Util::ResultHelper

    def initialize(params, current_user=nil)
      params.delete("controller")
      params.delete("action")
      params = clean(params)
      @params = params
      if @params["entity_name"]
        @entity = Entity.find_by name: @params["entity_name"]
      end
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
      if @entity.present?
        config["meta"][@entity.name.to_s.to_sym].each do |key, value|
          if  @params[key.to_s]
            error_object[key] = apply_validations(value[:validations], value[:data_kind], @params[key.to_s])
          else
            error_object[key] = field_missing_error
          end
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
            '',
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

    def has_max_one_record_allowed
      @entity.configuration == 2
    end

    def already_data_exist
      EntityDataVersion
          .where(status: [0, 1])
          .where(entity_id: @entity.id)
          .present?
    end



    def field_missing_error
      [{required: "This field is required"}]
      []
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

    def array(input)
      input.kind_of?(Array) ? nil : "Array is expected"
    end

    def url(input)
      pattern = /\A#{URI::regexp}\z/
      if input.length > 0 && (input =~ pattern) == nil
        return "Please enter valid URL"
      end
    end

    def date(input)
      pattern = /\d{4}-\d{1,2}-\d{1,2}$/
      if input.length > 0 && (input =~ pattern) == nil
        return "Date format is not valid"
      end
    end

    def min_bytes(validation, input)

    end

    def max_bytes(validation, input)

    end

    def accept(validation, input)

    end


  end
end