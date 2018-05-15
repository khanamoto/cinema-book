Rails.application.routes.draw do
  resources :users
  resources :registrations

  get 'sessions/new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root to: 'timeline#index'
end
