Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, GlobalConstant::Base.oauth[:key], GlobalConstant::Base.oauth[:secret],
           redirect_uri: GlobalConstant::Base.root_url + GlobalConstant::Base.oauth[:auth_callback_route],
           provider_ignores_state: true
end