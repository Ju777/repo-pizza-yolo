class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart_owner, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @all_carts = Cart.all
  end

  def show
    @cart_to_show = Cart.find(params[:id])
    @total_to_pay = total_cart
    @cart_schedule_state = is_cart_fully_scheduled
    @order = Order.where(user:current_user).last
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
      @cart.cart_products.each do |cart_product|
        total += cart_product.product.price*cart_product.quantity
      end
    return total
  end

  def is_cart_fully_scheduled
    # S'il y a le moindre cart_product dont le schedule n'est pas à jour, la méthode renvoie false. True dans le cas contraire.
    false_count = 0
    current_user.cart.cart_products.each do |cart_product|
      if cart_product.schedule.date.year == 1900
        false_count += 1
      end
    end

    if false_count == 0
      return true
    else
      return false
    end    
  end
end
