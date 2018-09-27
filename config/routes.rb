Rails.application.routes.draw do

  scope 'auth', controller: 'api_cms/user' do
    match '/:provider/callback' => :signin, as: 'signin',  via: [:GET]
    match '/logout' => :logout, as: 'logout', via: [:GET]
    match '/user' => :profile, as: 'profile', via: [:GET]
  end

  scope 'api/content', controller: 'api_cms/content' do

    # GET requests
    match '/entity_data' => :entity_data, via: [:GET]
    match '/configs' => :read_yml_config, via: [:GET]
    match '/configs/app' => :get_app_config, via: [:GET]
    match '/active' => :get_active_data, via: [:GET]
    match '/record' => :get_record, via: [:GET]
    match '/get_signed_url' => :get_signed_url, via: [:GET]
    match '/get_preview_url' => :get_preview_signed_url, via: [:GET]
    match '/published' => :get_published_data, via: [:GET]
    match '/draft_status' => :draft_status, via: [:GET]

    # POST requests
    match '/create' => :create_data, via: [:POST]
    match '/edit'   => :edit_data, via: [:POST]
    match '/delete' => :delete_data, via: [:POST]
    match '/publish' => :publish_data, via: [:POST]
    match '/sort' => :sort_data, via: [:POST]
    match '/rollback' => :rollback_publish, via: [:POST]
    match '/reset_to_publish' => :reset_to_publish, via: [:POST]
  end

  scope 'api/preview', controller: 'api_rest/preview' do
    match '/:entity' => :get_data, via: [:GET]
  end



end