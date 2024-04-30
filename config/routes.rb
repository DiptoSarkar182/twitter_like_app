Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"

  resources :posts
  resources :users_profile, only: [:show]
  resources :follows do
    member do
      post :follow_user
      post :unfollow_user
      get :show_followers
      get :show_following
    end
  end
end
