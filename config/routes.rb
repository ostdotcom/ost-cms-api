Rails.application.routes.draw do

  scope 'auth', controller: 'user' do
    match '/:provider/callback' => :signin, as: 'signin',  via: [:GET]
    match '/logout' => :logout, as: 'logout', via: [:GET]
    match '/user' => :profile, as: 'profile', via: [:GET]
  end

  scope 'api/content', controller: 'content' do

    # GET requests
    match '/entity_data' => :entity_data, via: [:GET]
    match '/configs' => :read_yml_config, via: [:GET]
    match '/active' => :get_active_data, via: [:GET]
    match '/record' => :get_record, via: [:GET]

    # POST requests
    match '/create' => :create_data, via: [:POST]
    match '/edit'   => :edit_data, via: [:POST]
    match '/delete' => :delete_data, via: [:POST]
    match '/publish' => :publish_data, via: [:POST]
    match '/sort' => :sort_data, via: [:POST]
  end

  scope 'api/published', controller: 'published' do
    match '' => :get_published_data, via: [:GET]
  end



end