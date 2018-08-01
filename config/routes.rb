Rails.application.routes.draw do

  get 'api/login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'api/logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'home', to: 'home#show'
  get 'dashboard', to: redirect('/dashboard')
  root to: "home#show"

end