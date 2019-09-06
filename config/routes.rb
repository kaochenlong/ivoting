Rails.application.routes.draw do
  devise_for :users

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

  # /api/v2/candidates
end
