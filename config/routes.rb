Rails.application.routes.draw do
  devise_for :users

  resources :products do
    member do
      put :add_to_cart
    end
  end

  resources :orders, only: [:create] do
    member do
      get :payment
    end
  end

  resource :cart, only: [:show, :destroy]
  get '/checkout', to: 'carts#checkout'

  # API
  namespace :api do
    namespace :v2 do
      resources :candidates, only: [:index, :show]
    end
  end

  resources :candidates do
    member do
      put :vote
      get :log
    end
  end

  root 'candidates#index'
end
