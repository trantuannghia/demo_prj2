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
  resources :posts, only: [:create, :destroy]
  resources :users
end
