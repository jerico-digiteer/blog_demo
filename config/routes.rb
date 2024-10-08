Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  resources :posts
  root "posts#feed"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
      resources :posts
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/feed" => "posts#feed"
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  
end
