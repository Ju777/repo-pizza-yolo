class OrdersController < ApplicationController
  def index
  end

  def show
  end

  def new
    puts "#"*100
    puts "ORDERS#NEW"
    puts "#"*100

    @cart_to_show = current_user.cart
    @order_to_pay = Order.where(user:current_user).last
  end

  def create
    #############################################
    # STRIPE V1 process begins
    # Before the rescue, at the beginning of the method
    # @current_order = Order.where(user:current_user).last
    # @stripe_amount = ((@current_order.total_amount)*100).to_i

    # begin
    #   customer = Stripe::Customer.create({
    #   email: params[:stripeEmail],
    #   source: params[:stripeToken],
    #   })
    #   charge = Stripe::Charge.create({
    #   customer: customer.id,
    #   amount: @stripe_amount,
    #   description: "Achat d'un produit",
    #   currency: 'eur',
    #   })
    #   final_pickup_code = "#{@current_order.id}##{@current_order.created_at.to_i}"
    #   @current_order.update(pickup_code:final_pickup_code)
    #   flash.notice="Commande validée, vous recevrez votre code de retrait à l'adresse #{current_user.email}."
    #   redirect_to root_path
      
    # rescue Stripe::CardError => e
    #   flash[:error] = e.message 
    #   redirect_to root_path
    # end
    # After the rescue, if the payment succeeded
    # STRIPE V1 process ends
    ############################################# 

    #############################################
    # STRIPE V2 process begins
    total_to_pay = params[:total]
    order = Order.create(total_amount:total_to_pay, pickup_code:"not_paid", user:current_user, restaurant: Restaurant.first)

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          name: 'Pizza-Yolo',
          amount: (total_to_pay.to_f*100).to_i,
          currency: 'eur',
          quantity: 1
        },
      ],
      success_url: orders_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: orders_cancel_url
    )
  
    pickup_code = "#{order.id}##{order.created_at.to_i}"
    order.update(pickup_code:pickup_code)
    
    respond_to do |format|
      format.js
    end
    # STRIPE V2 process ends
    ############################################ 
    empty_cart
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end
  
  def empty_cart
    cart_products_to_empty = current_user.cart.cart_products
    cart_products_to_empty.each do |cart_product|
      cart_product.destroy
    end
  end

end
