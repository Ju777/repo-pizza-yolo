Rails.application.routes.draw do
  get 'schedules/index'
  get 'schedules/show'
  get 'schedules/new'
  get 'schedules/create'
  get 'schedules/edit'
  get 'schedules/update'
  get 'schedules/destroy'
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
