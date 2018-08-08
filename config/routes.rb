Rails.application.routes.draw do

  scope 'auth', controller: 'sessions' do
    get '/:provider/callback' => :create
    get '/logout' => :destroy, as: 'destroy'
    get '/failure', to: redirect('/')
  end

  scope 'api', controller: 'api' do
    get '/login', to: redirect('/auth/google_oauth2'), as: 'login'
    get '/user' => :user_profile, as: 'user_profile'
    get '/entity_data' => :entity_data
    get '/configs' => :read_yml_config
    post '/create' => :create_data
    post '/edit'   => :edit_data
    post '/delete' => :delete_data
    post '/publish' => :publish_data
    get '/published' => :get_published_data
    get '/active' => :get_active_data
    get '/record' => :get_record
  end



  #get 'api/login', to: redirect('/auth/google_oauth2'), as: 'login'
 # get 'api/logout', to: 'sessions#destroy', as: 'logout'
 # get 'api/user/profile', to: 'sessions#getuser', as: 'getuser'
  #get 'auth/:provider/callback', to: 'sessions#create'

  #get 'home', to: 'home#show'
  #get 'dashboard', to: redirect('/dashboard')
  #root to: "home#show"

end