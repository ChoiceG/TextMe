Rails.application.routes.draw do
  resources :rooms

  root "pages#home"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"  # Optional, if you want to customize login
  }
  
  # You can keep the custom route for the new user session if needed:
  devise_scope :user do
    get "users", to: 'devise/sessions#new'
  end

  get 'user/:id', to: 'user#show', as: 'user'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
