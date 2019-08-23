Rails.application.routes.draw do
  resources :candidates do
    member do
      put :vote
    end
  end

  root 'candidates#index'
end
