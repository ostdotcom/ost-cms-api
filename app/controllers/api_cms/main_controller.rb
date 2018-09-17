module ApiCms

  class MainController < ApplicationController

    def current_user
      @current_user ||= begin
        _user = User.find(session[:user_id])
        (_user.present? && _user.state.present? && User.encrypt_user_state(_user.state) == session[:user_state]) ? _user : nil
      end if session[:user_id]
    end

    def user_signed_in?
      # converts current_user to a boolean by negating the negation
      !!current_user
    end

    def user_auth
      if !user_signed_in? || session[:expires_at] < Time.current
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
      else
        set_session_expiry
      end
    end

    def set_session_expiry
      session[:expires_at] = Time.current + 60.minutes
    end

  end

end