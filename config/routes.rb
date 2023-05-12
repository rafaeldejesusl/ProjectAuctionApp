Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :auctions, only: [:show]
  resources :items, only: [:index, :show, :new, :create]
  resources :lots, only: [:index, :show, :new, :create] do
    get 'new_item', on: :member
    post 'add_item', on: :member
    resources :items, only: [] do
      patch 'remove', on: :member
    end
    post 'approved', on: :member
    resources :bids, only: [:new, :create]
  end
end
