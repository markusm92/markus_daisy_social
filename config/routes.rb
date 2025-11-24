Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resource :registrations, only: [:new, :create]
  resource :session
  resources :passwords, param: :token

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root
  root "pages#home"
end
