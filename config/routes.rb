Rails.application.routes.draw do
  devise_for :users

  resources :candidates do
    member do
      put :vote
    end
  end

  root 'candidates#index'
end
