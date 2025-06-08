Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  resources :startups, only: [ :index, :new, :create, :show ] do
    member do
      post :like
    end
  end
  root "home#index"
  get "search", to: "home#search", as: :search
end
