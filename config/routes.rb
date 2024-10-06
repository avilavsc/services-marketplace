Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  authenticated :user, ->(user) { user.provider? } do
    get "dashboard", to: "dashboard#index", as: :provider_dashboard
  end

  resources :services, only: [ :index, :new, :create, :show ] do
    resources :reviews, only: [ :new, :create ]
    resources :contracts, only: [ :new, :create ] do
      collection do
        get "success", to: "contracts#success"
        get "cancel", to: "contracts#cancel"
      end
    end
  end

  resources :contracts, only: [ :index, :destroy ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
