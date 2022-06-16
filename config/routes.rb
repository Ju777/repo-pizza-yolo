Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :carts
  resources :orders
  resources :users, only: [:show, :edit, :update] do
    resources :avatars, only: [:create]
  end
  resources :products
  resources :cart_products
  get '/story', to: 'static_pages#story'
end
