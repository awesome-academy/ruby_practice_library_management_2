Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root "home#index"

  resources :books, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
  end
end
