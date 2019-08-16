Rails.application.routes.draw do
  resources :candidates

  root 'candidates#index'
end
