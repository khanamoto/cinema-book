Rails.application.routes.draw do
  resources :users

  get 'registrations/new'

  get 'sessions/login'
  delete 'sessions/logout'
end
