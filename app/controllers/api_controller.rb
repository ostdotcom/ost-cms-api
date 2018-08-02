class ApiController < ApplicationController
  def user_profile
    if user_signed_in?
      if is_whitelisted?
        user = {
            success: true,
            data: current_user
        }
      else
        user = {
            success: false,
            err:{
              code: 'not_whitelisted_user'
            }
        }
      end
    else
      user = {
          success: false,
          err: {
              code: 'auth_error'
          }
      }
    end
    render json: user.to_json
  end
end