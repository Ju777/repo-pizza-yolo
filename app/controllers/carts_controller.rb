class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart_owner, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @all_carts = Cart.all
  end

  def show
    @cart_to_show = Cart.find(params[:id])
    @total_to_pay = total_cart

    # The following line is used with Stripe payment V1 only. It has to to be commented while using Stripe payment V2.
    # @order_to_pay = Order.create(total_amount:@total_to_pay, user:current_user, pickup_code:"not_paid", restaurant: Restaurant.first)

  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def check_cart_owner
    cart_owner = Cart.find(params[:id]).user
        
    unless current_user == cart_owner
      flash.notice = "Accès non autorisé."
      redirect_to root_path
    end
  end

  def total_cart
    @cart = Cart.find(params[:id])
    total = 0
      @cart.products.each do |product|
        total += product.price
      end
    return total
  end
end
