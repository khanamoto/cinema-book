Rails.application.routes.draw do
  resources :users
  resources :registrations

  get 'sessions/login'
  delete 'sessions/logout'

  root to: 'timeline#index'
end
