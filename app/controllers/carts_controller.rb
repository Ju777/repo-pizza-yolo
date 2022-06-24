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
    @all_products = @cart_to_show.cart_products.order(:created_at)
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
    current_cart = Cart.find(params[:id])
    empty_the_cart
  end

  private

  def check_cart_owner
    cart_owner = Cart.find(params[:id]).user
  
    unless current_user == cart_owner
      flash.notice = "Accès non autorisé"
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

  def empty_the_cart
    current_cart = Cart.find(params[:id])
    current_products = current_cart.cart_products

    current_products.each do |cart_product|
      cart_product.destroy
    end

    respond_to do |format|
      format.html {
        flash.notice = "Panier vidé"
        redirect_to cart_path(current_user.cart)
      }
      format.js {}
    end
  end

end
