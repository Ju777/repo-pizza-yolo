Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :carts
      resources :cart_products
      resources :categories
      resources :comments
      resources :orders
      resources :products
      resources :product_restaurants
      resources :restaurants
      resources :schedules

      root to: "users#index"
    end
  root 'products#landing'
  devise_for :users
  
  resources :carts
  resources :cart_products 
  resources :orders
  get 'cancel', to: 'orders#cancel', as: 'orders_cancel'
  get 'success', to: 'orders#success', as: 'orders_success'

  resources :users, only: [:show, :edit, :update] do
    resources :avatars, only: [:create]
  end

  resources :products
  get '/story', to: 'static_pages#story'
  resources :schedules
end
