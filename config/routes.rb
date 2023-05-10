Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :items, only: [:index, :show, :new, :create]
  resources :lots, only: [:index, :show]
end
