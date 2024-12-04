Rails.application.routes.draw do
  resources :warehouses
  resources :shelves
  resources :plants
  resources :hectares
  resources :boxes
  resources :users, except: [ :login, :logout ]

  get "login", to: "authentication_views#login"
  post "login", to: "authentication_views#login"
  delete '/logout', to: 'authentication_views#logout', as: :logout

  patch 'boxes/release_kilos', to: 'boxes#release_kilos', as: 'release_kilos'
  

  

  post "authentication/login", to: "authentication#login"
  post "authentication/logout", to: "authentication#logout"

  get '/hectares/:id/authorize', to: 'hectares#authorize'

  resources :hectares do
    patch :authorize, on: :member
  end

  root "users#index"
end
