Rails.application.routes.draw do

  scope 'auth', controller: 'sessions' do
    match '/:provider/callback' => :create, via: [:GET]
    match '/logout' => :destroy, as: 'destroy', via: [:GET]
    get '/failure', to: redirect('/')
  end

  scope 'api', controller: 'api' do
    #GET requests
    match '/user' => :user_profile, as: 'user_profile', via: [:GET]
    match '/entity_data' => :entity_data, via: [:GET]
    match '/configs' => :read_yml_config, via: [:GET]
    match '/published' => :get_published_data, via: [:GET]
    match '/active' => :get_active_data, via: [:GET]
    match '/record' => :get_record, via: [:GET]
    #POST requests
    match '/create' => :create_data, via: [:POST]
    match '/edit'   => :edit_data, via: [:POST]
    match '/delete' => :delete_data, via: [:POST]
    match '/publish' => :publish_data, via: [:POST]
    match '/sort' => :sort_data, via: [:POST]
  end




end