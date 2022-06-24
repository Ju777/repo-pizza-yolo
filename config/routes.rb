Rails.application.routes.draw do
root 'products#landing'

  namespace :admin do
      resources :users
      resources :carts
      #resources :cart_products
      resources :comments
      resources :orders
      resources :restaurants
      resources :categories
      resources :products
      resources :product_restaurants

      root to: "users#index"
    end

  
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
