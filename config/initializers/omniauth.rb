OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '1075579052937-tfa52mo9pc3rtpfr5500321l50clju25.apps.googleusercontent.com', 'RNlmeLP8mMYonNoBw-X8GpvD', {
                             client_options: {
                                 ssl: {
                                     ca_file: Rails.root.join("cacert.pem").to_s
                                 }
                             }
                         }
end