Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'

  resources :carts
  resources :orders

  resources :users, only: [:show, :edit, :update]  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products
  resources :cart_products

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
