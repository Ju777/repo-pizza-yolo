Rails.application.routes.draw do
  get 'cart/index'
  get 'cart/show'
  get 'cart/new'
  get 'cart/create'
  get 'cart/edit'
  get 'cart/update'
  get 'cart/destroy'
  devise_for :users
  root 'static_pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
