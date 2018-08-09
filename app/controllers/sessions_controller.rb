
class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    if is_whitelist?(auth.info.email)
      @user = User.find_or_create_from_auth_hash(auth)
      session[:user_id] = @user.id
      redirect_page = "/dashboard"
    else
      redirect_page = "/?err=not_whitelisted"
    end
    redirect_to redirect_page
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end

  private

  def is_whitelist?(user_email)
    # Logic to check whitelist
    @whitelisted_users = ["mayur@ost.com", "akshay@ost.com"]
    @whitelisted_users.include? user_email
  end
end