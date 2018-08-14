
class UserController < ApplicationController

  def signin
    # some logic to check whitelist
    auth = request.env["omniauth.auth"]
    if is_whitelist(auth.info.email)
      @user = User.find_or_create_from_auth_hash(auth)
      session[:user_id] = @user.id
      redirect_page = GlobalConstant::Base.cms_api[:auth_success_route]
    else
      redirect_page = GlobalConstant::Base.cms_api[:auth_failure_route]
    end
    redirect_to redirect_page
  end

  def logout
    session[:user_id] = nil
    redirect_to "/"
  end

  def profile
    response = success_with_data(current_user.attributes)
    render_api_response(response)
  end

  private

  def is_whitelist(user_email)
    @whitelisted_users = GlobalConstant::Base.cms_api[:whitelisted_users].split(' ')
    @whitelisted_users.include? user_email
  end

  def filter_user_data(user)

  end
end