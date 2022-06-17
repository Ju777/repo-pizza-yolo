Rails.application.routes.draw do
  root 'products#index'
  devise_for :users
  
  resources :carts
  resources :orders

  scope '/orders' do
    # post 'create', to: 'orders#create', as: orders_create
    get 'cancel', to: 'orders#cancel', as: 'orders_cancel'
    get 'success', to: 'orders#success', as: 'orders_success'
  end

  resources :users, only: [:show, :edit, :update] do
    resources :avatars, only: [:create]
  end

  resources :products
  resources :cart_products
  get '/story', to: 'static_pages#story'
end
