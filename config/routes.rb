Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root "home#index"

  resources :books, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    resources :borrow_requests, only: [:new, :create] do
      member do
        patch :cancel
      end
    end
  end

  resources :users, only: [] do
    resources :borrow_requests, only: [:index], controller: "borrow_requests" do
      collection do
        get "status/:status", to: "borrow_requests#index", as: :status
      end
    end
  end
end
