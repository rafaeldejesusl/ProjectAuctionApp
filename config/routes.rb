Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'auctions/:id', to: 'auctions#show', as: 'auction'
  resources :items, only: [:index, :show, :new, :create]
  resources :lots, only: [:index, :show, :new, :create] do
    get 'new_item', on: :member
    post 'add_item', on: :member
    resources :items, only: [] do
      patch 'remove', on: :member
    end
    post 'approved', on: :member
  end
end
