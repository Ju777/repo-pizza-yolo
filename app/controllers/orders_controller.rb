class OrdersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @cart_to_show = current_user.cart
    @order_to_pay = Order.where(user:current_user).last
  end

  def create
    @current_order = Order.where(user:current_user).last
    
    # Before the rescue, at the beginning of the method
    @stripe_amount = ((@current_order.total_amount)*100).to_i
    begin
      customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
      })
      charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @stripe_amount,
      description: "Achat d'un produit",
      currency: 'eur',
      })
      final_pickup_code = "#{@current_order.id}##{@current_order.created_at.to_i}"
      @current_order.update(pickup_code:final_pickup_code)
      flash.notice="Commande validée, vous recevrez votre code de retrait à l'adresse #{current_user.email}."
      redirect_to root_path
      
    rescue Stripe::CardError => e
      flash[:error] = e.message 
      redirect_to new_order_path
    end
    # After the rescue, if the payment succeeded

    empty_cart
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 
  
  def empty_cart
    cart_products_to_empty = current_user.cart.cart_products
    cart_products_to_empty.each do |cart_product|
      cart_product.destroy
    end
  end

end
