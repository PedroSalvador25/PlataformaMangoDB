Rails.application.routes.draw do
  resources :warehouses
  resources :shelves
  resources :plants
  resources :hectares
  resources :boxes
  resources :users, except: [:login, :logout]

  get 'login', to: 'users#login'
  get 'logout', to: 'users#logout'
  post 'authentication/login', to: 'authentication#login'
  post 'authentication/logout', to: 'authentication#logout'

  root "users#index"
end

