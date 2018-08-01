
class SessionsController < ApplicationController

  def create
    @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    session[:user_id] = @user.id
    redirect_to :dashboard
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def getuser
    if user_signed_in?
      user = {
          success: true,
          data: current_user
      }
    else
      user = {
          success: false,
          err: {
              code: 'temp'
          }
      }
    end
    render json: user.to_json
  end

end