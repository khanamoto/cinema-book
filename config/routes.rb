Rails.application.routes.draw do
  resources :registrations
  resources :films

  resources :users do
    member do
      get :password
      patch :change_password
    end
  end
  # get ':user_name/:id' => 'users#show'

  resources :timeline do
    get 'page/:page', action: :index, on: :collection
  end

  get 'sessions/new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'terms', to: 'static#terms'
  get 'privacy', to: 'static#privacy'

  root to: 'timeline#index'
end
