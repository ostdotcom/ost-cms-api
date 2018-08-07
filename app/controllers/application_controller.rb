class ApplicationController < ActionController::Base

  include Sanitizer

  protect_from_forgery with: :exception
  helper_method :current_user
  #prepend_around_action :handle_exceptions_gracefully
  before_action :sanitize_params

  after_action :set_response_headers


  def authenticate
    redirect_to :login unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_whitelisted?

   if ! is_whitelisted
     session[:user_id] = nil
   end
   is_whitelisted
  end

  def user_signed_in?
    # converts current_user to a boolean by negating the negation
    puts "Current users"
    puts session[:user_id]
    puts current_user
    !!current_user
  end


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
      # ApplicationMailer.notify(
      #     body: {exception: {message: se.message, backtrace: se.backtrace}},
      #     data: {
      #         'params' => params
      #     },
      #     subject: 'Exception in API'
      # ).deliver

      r = Result::Base.exception(
          se,
          {
              error: 'swr',
              error_message: 'Something Went Wrong',
              data: params
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
    if !service_response.success? && !Rails.env.development?
      ApplicationMailer.notify(
          body: {},
          data: {
              response_hash: response_hash
          },
          subject: 'Error in KYC submit API'
      ).deliver if params[:action] == 'kyc_submit' && params[:controller] == 'web/saas_user/token_sale'

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
