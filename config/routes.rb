Rails.application.routes.draw do
  root "articles#index"

  resources :users, only: [:create, :show, :edit, :update]

  # User authentication routes
  get "/signup", to: "users#new"
  get "/signin", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  resources :articles do
    resources :comments
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

