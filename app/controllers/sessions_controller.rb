
class SessionsController < ApplicationController

  def create
    # some logic to check whitelist
    auth = request.env["omniauth.auth"]
    Rails.logger.debug(auth.inspect);
    Rails.logger.debug(auth.info.email.inspect);
    if is_whitelist(auth.info.email)
      Rails.logger.debug(User.all.inspect);
      @user = User.find_or_create_from_auth_hash(auth)
      session[:user_id] = @user.id
      redirect_page = "/go-to-dashboard"
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

  def is_whitelist(user_email)
    @whitelisted_users = ["mayur@ost.com", "akshay@ost.com", "preshita@ost.com"]
    @whitelisted_users.include? user_email
  end
end