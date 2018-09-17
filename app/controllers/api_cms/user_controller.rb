module  ApiCms
  class UserController < ApiCms::MainController

    before_action :user_auth, except: [:signin, :logout]

    def signin
      # some logic to check whitelist
      auth = request.env["omniauth.auth"] || {}
      auth.info = auth.info || {}
      state = params["state"]

      @user = User.find_or_create_from_auth_hash(auth, state) if GlobalConstant::Email.is_whitelisted_email?(auth.info.email)

      if @user.present?
        session[:user_id] = @user.id
        session[:user_state] = User.encrypt_user_state(@user.state)
        set_session_expiry
        redirect_page = GlobalConstant::Base.cms_api[:auth_success_route]
      else
        redirect_page = GlobalConstant::Base.cms_api[:auth_failure_route]
      end

      redirect_to redirect_page
    end

    def logout
      session[:user_id] = nil
      session[:user_state] = nil
      redirect_to "/"
    end

    def profile
      response = success_with_data(filter_user_data(current_user.attributes))
      render_api_response(response)
    end

    private

    def filter_user_data(user)
      filtered_info = {}
      info = [ "first_name", "last_name", "picture"]
      info.each do |item|
        filtered_info[item] = user[item]
      end
      filtered_info
    end
  end
end