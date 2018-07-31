Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "1075579052937-tfa52mo9pc3rtpfr5500321l50clju25.apps.googleusercontent.com", "RNlmeLP8mMYonNoBw-X8GpvD",
           redirect_uri: 'https://securedhost.com:8443/auth/google_oauth2/callback'
end