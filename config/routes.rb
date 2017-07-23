Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/search", to: "posts#search"
  resources :posts
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :comments
  resources :relationships, only: [:create, :destroy]
  resources :tags
end
