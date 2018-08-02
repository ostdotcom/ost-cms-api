class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def authenticate
    redirect_to :login unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_whitelisted?
    @whitelisted_users =  ["mayur@ost.com", "akshay@ost.com"]
    is_whitelisted = @whitelisted_users.include? @current_user.email
   if ! is_whitelisted
     session[:user_id] = nil
   end
   is_whitelisted
  end

  def user_signed_in?
    # converts current_user to a boolean by negating the negation
    !!current_user
  end
end
