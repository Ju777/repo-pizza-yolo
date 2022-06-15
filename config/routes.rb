Rails.application.routes.draw do
  get 'avatars/create'
  devise_for :users
  root 'static_pages#index'

  resources :carts
  resources :orders
  resources :users do
    resources :avatars, only: [:create]
  end
  resources :products
  resources :cart_products


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
