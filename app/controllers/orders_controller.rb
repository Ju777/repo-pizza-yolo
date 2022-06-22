class OrdersController < ApplicationController
  def index
  end

  def show
  end

  def new
    # Tout ce ceci est utilisé dans Schedule#new
    # @cart_to_show = current_user.cart
    # @pizzas_quantity = pizzas_to_cook
    # @total_to_pay = total_cart
    # @order = Order.create(total_amount: @total_to_pay, user: current_user, restaurant: Restaurant.first)
    # @order.update(pickup_code: "#{@order.id}##{@order.created_at.to_i}")
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
    
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          name: 'Pizza-Yolo',
          amount: ((params[:total].to_f)*100).to_i,
          currency: 'eur',
          quantity: 1
        },
      ],
      success_url: orders_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: orders_cancel_url
    )
  
    respond_to do |format|
      format.js
    end

    # STRIPE V2 process ends
    ############################################
 
  end

  def edit
  end

  def update
  end

  def destroy
    empty_cart
    Order.last.destroy

    flash.notice= "Panier vidé, commande annulée."
    redirect_to root_path    
  end

  def success
    puts "#"*100
    puts "Je suis la méthode success ! :) ."
    puts "#"*100
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    total_amount = params[:total]
    order = current_user.orders.last
    pickup_code = "#{order.id}##{order.created_at.to_i}"
    order.update(pickup_code:pickup_code)
    puts "#"*100
    puts "order = #{order.inspect}."
    puts "#"*100
    empty_cart
    clean_old_schedules
    order_recap
  end

  def cancel
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end
  
  private 

  def empty_cart
    puts "#"*100
    puts "Je suis la méthode empty_cart DEBUT ! :) ."
    puts "#"*100
    cart_products_to_empty = current_user.cart.cart_products
    cart_products_to_empty.each do |cart_product|
    puts "#"*100
    puts "Je suis la méthode empty_cart EACH ! :) ."
    puts "#"*100
      cart_product.destroy
    end

  end

  def clean_old_schedules
    puts "#"*100
    puts "Je suis la méthode clean_old_schedules DEBUT ! :) ."
    puts "#"*100
    cart_products = current_user.cart.cart_products
    cart_products.each do |cart_product|
      puts "#"*100
      puts "Je suis la méthode clean_old_schedules DANS EACH ! :) ."
      puts "#"*100
      cart_product.schedule.destroy
    end

    Schedule.all.each do |schedule|
      if schedule.date.year == 1900 && schedule.created_at < Time.now - 3600*24*2
        schedule.destroy
      end
    end
  end

  def order_recap
    order = current_user.orders.last
    UserMailer.customer_order_email(order).deliver_now 
    UserMailer.pizzeria_order_email(order).deliver_now
  end
end
