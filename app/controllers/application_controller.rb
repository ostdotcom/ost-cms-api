class ApplicationController < ActionController::Base

  include ::Util::ResultHelper
  include Sanitizer
  protect_from_forgery with: :exception
  prepend_around_action :handle_exceptions_gracefully
  before_action :sanitize_params
  after_action :set_response_headers

  def sanitize_params
    sanitize_params_recursively(params)
  end

  def set_response_headers
    response.headers["X-Robots-Tag"] = 'noindex, nofollow'
    response.headers["Content-Type"] = 'application/json; charset=utf-8'
  end

  def handle_exceptions_gracefully
    begin
      yield
    rescue => se
      Rails.logger.error("Exception in API: #{se.message}")
      r = Result::Base.exception(
          se,
          {
              error: 'swr',
              error_message: 'Something Went Wrong',
              data: params,
              http_code: GlobalConstant::ErrorCode.internal_server_error
          }
      )
      render_api_response(r)
    end
  end

  def render_api_response(service_response)
    # calling to_json of Result::Base
    response_hash = service_response.to_json
    http_status_code = service_response.http_code

    # filter out not allowed http codes
    http_status_code = GlobalConstant::ErrorCode.ok unless GlobalConstant::ErrorCode.allowed_http_codes.include?(http_status_code)

    # sanitizing out error and data. only display_text and display_heading are allowed to be sent to FE.
    if !service_response.success?
      ApplicationMailer.notify(
          body: {},
          data: {
              response_hash: response_hash
          },
          subject: 'Error in OST CMS API'
      ).deliver if !Rails.env.development?

      err = response_hash.delete(:err) || {}
      response_hash[:err] = {
          display_text: (err[:display_text].to_s),
          display_heading: (err[:display_heading].to_s),
          error_data: (err[:error_data] || {}),
          code: (err[:code] || {})
      }

      response_hash[:data] = {}
    end

    (render plain: Oj.dump(response_hash, mode: :compat), status: http_status_code)
  end

end
