Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :auctions, only: [:show] do
    get 'search', on: :collection
    get 'won', on: :collection
  end
  resources :items, only: [:index, :show, :new, :create] do
    patch 'remove', on: :member
  end
  resources :lots, only: [:index, :show, :new, :create] do
    get 'new_item', on: :member
    get 'finished', on: :collection
    get 'unanswered', on: :collection
    post 'add_item', on: :member
    post 'approved', on: :member
    post 'close', on: :member
    post 'cancel', on: :member
    resources :bids, only: [:new, :create]
    resources :questions, only: [:new, :create] do
      resources :answers, only: [:new, :create]
      post 'hide', on: :member
    end
  end
  resources :blocked_cpfs, only: [:index, :new, :create]
end
