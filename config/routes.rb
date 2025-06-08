Rails.application.routes.draw do
  get "/privacy", to: "static_pages#privacy"
  get "/terms", to: "static_pages#terms"
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get  "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  resources :sessions, only: [ :index, :show, :destroy ]
  resource  :password, only: [ :edit, :update ]
  namespace :identity do
    resource :email,              only: [ :edit, :update ]
    resource :email_verification, only: [ :show, :create ]
    resource :password_reset,     only: [ :new, :edit, :create, :update ]
  end
  get  "/auth/failure",            to: "sessions/omniauth#failure"
  get  "/auth/:provider/callback", to: "sessions/omniauth#create"
  post "/auth/:provider/callback", to: "sessions/omniauth#create"
  get "up" => "rails/health#show", as: :rails_health_check
  resources :startups, only: [ :index, :new, :create, :show ] do
    member do
      post :like
    end
  end
  root "home#index"
  get "search", to: "home#search", as: :search
end
