
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
      redirect_page = GlobalConstant::Base.cms_api[:auth_success_route]
    else
      redirect_page = GlobalConstant::Base.cms_api[:auth_failure_route]
    end
    redirect_to redirect_page
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end

  private

  def is_whitelist(user_email)
    @whitelisted_users = GlobalConstant::Base.cms_api[:whitelisted_users].split(' ')
    @whitelisted_users.include? user_email
  end
end