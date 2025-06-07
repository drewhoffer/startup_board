Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  resources :startups, only: [ :index, :new, :create, :show ]
  root "home#index"
end
