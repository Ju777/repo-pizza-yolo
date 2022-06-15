Rails.application.routes.draw do
  devise_for :users
  root 'products#index'

  resources :carts
  resources :orders
  resources :users
  resources :products
  resources :cart_products

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
