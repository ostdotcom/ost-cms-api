# Be sure to restart your server when you modify this file.
Rails.application.config.middleware.use ActionDispatch::Cookies
Rails.application.config.middleware.use ActionDispatch::Session::CookieStore, key: '_ost_cms_api_session', http_only: true, secure: Rails.env.production?, same_site: :strict