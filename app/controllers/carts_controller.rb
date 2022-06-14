class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart_owner, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @all_carts = Cart.all
  end

  def show
    @cart_to_show = Cart.find(params[:id])
    @total_to_pay = total_cart
    order_to_create = Order.new(total_amount:@total_to_pay, user:current_user)
    puts "#"*100
    puts "order_to_create = #{order_to_create}"
    puts "order_to_create.total_amount = #{order_to_create.total_amount}"
    puts "order_to_create.pickup_code = #{order_to_create.pickup_code}"
    puts "order_to_create.user = #{order_to_create.user}"
    puts "order_to_create.created_at = #{order_to_create.created_at}"
    puts "#"*100
    order_to_create.update(pickup_code:"#{order_to_create.id} # #{order_to_create.created_at}")
    puts "#"*100
    puts "order_to_create = #{order_to_create}"
    puts "order_to_create.total_amount = #{order_to_create.total_amount}"
    puts "order_to_create.pickup_code = #{order_to_create.pickup_code}"
    puts "order_to_create.user = #{order_to_create.user}"
    puts "#"*100

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
        total = total + product.price
      end
    return total
  end
end
