# Success Result Usage:
# > s = Result::Base.success(data: {"k1" => "v1"})
# => #<Result::Base:0x007ffbff521d38 @error=nil, @error_message=nil, @message=nil, @data={"k1"=>"v1"}>
# > s.data
# => {"k1"=>"v1"}
# > s.success?
# => true
# > s.to_json
# => {:success=>true, :data=>{"k1"=>"v1"}}
#
# Error Result Usage:
# > er = Result::Base.error({error: 'err_1', error_message: 'msg', error_action: 'do nothing', error_display_text: 'qwerty', data: {k1: 'v1'}})
# => #<Result::Base:0x007fa08a050848 @error="err_1", @error_message="msg", @error_action="do nothing", @error_display_text="qwerty", @message=nil, @http_code=200, @data={:k1=>"v1"}>
# > er.data
# => {"k1"=>"v1"}
# er.success?
# => false
# > er.to_json
# => {:success=>false, :err=>{:code=>"err_1", :msg=>"msg", :action=>"do nothing", :display_text=>"qwerty"}, :data=>{:k1=>"v1"}}
#
# Exception Result Usage:
# > ex = Result::Base.exception(Exception.new("hello"), {error: "er1", error_message: "err_msg", data: {"k1" => "v1"}})
# => #<Result::Base:0x007fbcccbeb140 @error="er1", @error_message="err_msg", @message=nil, @data={"k1"=>"v1"}>
# > ex.data
# => {"k1"=>"v1"}
# > ex.success?
# => false
# > ex.to_json
# => {:success=>false, :err=>{:code=>"er1", :msg=>"err_msg"}}
#
module Result

  class Base

    attr_accessor :error,
                  :error_message,
                  :error_display_text,
                  :error_display_heading,
                  :error_action,
                  :error_data,
                  :message,
                  :data,
                  :exception,
                  :http_code


    def initialize(params = {})
      set_error(params)
      set_message(params[:message])
      set_http_code(params[:http_code])
      @data = params[:data] || {}
    end

    def set_http_code(h_c)
      @http_code = h_c || GlobalConstant::ErrorCode.ok
    end


    def set_error(params)
      @error = params[:error] if params.key?(:error)
      @error_message = params[:error_message] if params.key?(:error_message)
      @error_data = params[:error_data] if params.key?(:error_data)
      @error_action = params[:error_action] if params.key?(:error_action)
      @error_display_text = params[:error_display_text] if params.key?(:error_display_text)
      @error_display_heading = params[:error_display_heading] if params.key?(:error_display_heading)
    end


    def set_message(msg)
      @message = msg
    end


    def set_exception(e)
      @exception = e
    end


    def valid?
      !invalid?
    end


    def invalid?
      errors_present?
    end

    [:error?, :errors?, :failed?].each do |name|
      define_method(name) { invalid? }
    end


    [:success?].each do |name|
      define_method(name) { valid? }
    end


    def errors_present?
      @error.present? ||
          @error_message.present? ||
          @error_data.present? ||
          @error_display_text.present? ||
          @error_display_heading.present? ||
          @error_action.present? ||
          @exception.present?
    end


    def exception_message
      @e_m ||= @exception.present? ? @exception.message : ''
    end


    def exception_backtrace
      @e_b ||= @exception.present? ? @exception.backtrace : ''
    end


    def [](key)
      instance_variable_get("@#{key}")
    end

    # Error
    #
    # * Author: Kedar
    # * Date: 09/10/2017
    # * Reviewed By: Sunil Khedar
    #
    # @return [Result::Base] returns object of Result::Base class
    #
    def self.error(params)
      new(params)
    end

    # Success
    #
    # * Author: Kedar
    # * Date: 09/10/2017
    # * Reviewed By: Sunil Khedar
    #
    # @return [Result::Base] returns object of Result::Base class
    #
    def self.success(params)
      new(params.merge!(no_error))
    end

    # Exception
    #
    # * Author: Kedar
    # * Date: 09/10/2017
    # * Reviewed By: Sunil Khedar
    #
    # @return [Result::Base] returns object of Result::Base class
    #
    def self.exception(e, params = {})
      obj = new(params)
      obj.set_exception(e)
      if params[:notify].present? ? params[:notify] : true
        send_notification_mail(e, params)
      end
      return obj
    end

    # Send Notification Email
    #
    # * Author: Kedar
    # * Date: 09/10/2017
    # * Reviewed By: Sunil Khedar
    #
    def self.send_notification_mail(e, params)
      ApplicationMailer.notify(
          body: {exception: {message: e.message, backtrace: e.backtrace, error_data: @error_data}},
          data: params,
          subject: "#{params[:error]} : #{params[:error_message]}"
      ).deliver
    end

    # No Error
    #
    # * Author: Kedar
    # * Date: 09/10/2017
    # * Reviewed By: Sunil Khedar
    #
    # @return [Hash] returns Hash
    #
    def self.no_error
      @n_err ||= {
          error: nil,
          error_message: nil,
          error_data: nil,
          error_action: nil,
          error_display_text: nil,
          error_display_heading: nil
      }
    end

    # Fields
    #
    # * Author: Kedar
    # * Date: 09/10/2017
    # * Reviewed By: Sunil Khedar
    #
    # @return [Array] returns Array object
    #
    def self.fields
      error_fields + [:data, :message]
    end

    # Error Fields
    #
    # * Author: Kedar
    # * Date: 09/10/2017
    # * Reviewed By: Sunil Khedar
    #
    # @return [Array] returns Array object
    #
    def self.error_fields
      [
          :error,
          :error_message,
          :error_data,
          :error_action,
          :error_display_text,
          :error_display_heading
      ]
    end


    def to_hash
      self.class.fields.each_with_object({}) do |key, hash|
        val = send(key)
        hash[key] = val if val.present?
      end
    end

    def is_entity_not_found_action?
      http_code == GlobalConstant::ErrorCode.not_found
    end



    def to_json
      hash = self.to_hash

      if (hash[:error] == nil)
        h = {
            success: true
        }.merge(hash)
        h
      else
        {
            success: false,
            err: {
                code: hash[:error],
                msg: hash[:error_message],
                action: hash[:error_action] || GlobalConstant::ErrorAction.default,
                display_text: hash[:error_display_text].to_s,
                display_heading: hash[:error_display_heading].to_s,
                error_data: hash[:error_data] || {}
            },
            data: hash[:data]
        }
      end

    end

  end

end
