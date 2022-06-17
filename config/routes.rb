Rails.application.routes.draw do
  root 'products#index'
  devise_for :users
  
  resources :carts
  resources :orders
  get 'cancel', to: 'orders#cancel', as: 'orders_cancel'
  get 'success', to: 'orders#success', as: 'orders_success'

  resources :users, only: [:show, :edit, :update] do
    resources :avatars, only: [:create]
  end

  resources :products
  resources :cart_products
  get '/story', to: 'static_pages#story'
end
