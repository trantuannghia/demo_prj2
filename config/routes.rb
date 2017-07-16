Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    confirmations: "users/confirmations"
  }

  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  root "static_pages#home"
  get "/help", to: "static_pages#help"
  resources :posts, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :comments
  resources :relationships, only: [:create, :destroy]
end
