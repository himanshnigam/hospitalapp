Rails.application.routes.draw do
  get 'notifications/index'

  resources :users
  post '/auth/login', to: 'authentication#login'
  post '/auth/signup', to: 'authentication#signup'

  resources :doctors
  post '/doctors/signup', to: 'doctor_authentication#signup'
  post '/doctors/login', to: 'doctor_authentication#login'

  resources :patients
  post '/patients/signup', to: 'patient_authentication#signup'
  post '/patients/login', to: 'patient_authentication#login'

  resources :appointments

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:index, :create]
  end

  resources :notifications, only: [:index]

  resources :follows, only: [:create, :destroy]

  get 'users/:id/following', to: 'follows#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
