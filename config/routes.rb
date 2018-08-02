Rails.application.routes.draw do

  scope 'auth', controller: 'sessions' do
    get '/:provider/callback' => :create
    get '/logout' => :destroy, as: 'destroy'
    get '/failure', to: redirect('/')
  end

  scope 'api', controller: 'api' do
    get '/login', to: redirect('/auth/google_oauth2'), as: 'login'
    get '/user/profile' => :user_profile, as: 'user_profile'
  end



  #get 'api/login', to: redirect('/auth/google_oauth2'), as: 'login'
 # get 'api/logout', to: 'sessions#destroy', as: 'logout'
 # get 'api/user/profile', to: 'sessions#getuser', as: 'getuser'
  #get 'auth/:provider/callback', to: 'sessions#create'

  #get 'home', to: 'home#show'
  #get 'dashboard', to: redirect('/dashboard')
  #root to: "home#show"

end