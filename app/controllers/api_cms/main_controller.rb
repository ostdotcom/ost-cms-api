module ApiCms

  class MainController < ApplicationController

    def current_user
      @current_user ||= begin
        _user = User.find(session[:user_id])
        (_user.state.present? && User.encrypt_user_state(_user.state) == session[:user_state]) ? _user : nil
      end if session[:user_id]
    end

    def user_signed_in?
      # converts current_user to a boolean by negating the negation
      !!current_user
    end

    def user_auth
      if !user_signed_in?
        r = error_with_data(
            'user_not_authenticated',
            'User is not authenticated',
            'User is not authenticated',
            GlobalConstant::ErrorAction.default,
            {},
            {},
            GlobalConstant::ErrorCode.unauthorized_access
        )
        render_api_response(r)
      end
    end
  end

end