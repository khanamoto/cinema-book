Rails.application.routes.draw do
  resources :registrations, only: [ :new, :create ]
  resources :films, only: [ :new, :create, :show, :edit, :update, :destroy ]

  resources :users, only: [ :show, :edit, :update, :destroy ] do
    member do
      get :password
      patch :change_password
    end
  end
  # get ':user_name/:id' => 'users#show'

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :timeline, only: [ :index ] do
    get 'page/:page', action: :index, on: :collection
  end

  get 'sessions/new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'contacts', to: 'contacts#new'
  post 'contacts/sendmail', to: 'contacts#create'
  post 'contacts/confirm'
  get 'contacts/complete'

  get 'terms', to: 'static#terms'
  get 'privacy', to: 'static#privacy'

  root to: 'timeline#index'
end
