class OrdersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
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
      cancel_url: orders_cancel_url + '?session_id={CHECKOUT_SESSION_ID}'
    )
  
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def update
  end

  def destroy
    empty_cart
    current_user.orders.last.destroy
    flash.notice= "Panier vidé, commande annulée"
    redirect_to root_path    
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    total_amount = params[:total]
    order = current_user.orders.last
    pickup_code = "#{order.id}##{order.created_at.to_i}"
    order.update(pickup_code:pickup_code)
    order_recap
    empty_cart
    clean_old_schedules
    clean_wrong_orders
  end

  def cancel
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end
  
  private 

  def empty_cart
    cart_products_to_empty = current_user.cart.cart_products
    cart_products_to_empty.each do |cart_product|
      cart_product.destroy
    end
  end

  def clean_old_schedules
    Schedule.all.each do |schedule|
      if schedule.date.year == 1900 && schedule.created_at < Time.now 
        schedule.destroy
      end
    end
  end

  def clean_wrong_orders
    Order.where(pickup_code: nil).each do |order|
        order.destroy
    end
  end

  def order_recap
    order = current_user.orders.last
    UserMailer.customer_order_email(order).deliver_now 
    UserMailer.pizzeria_order_email(order).deliver_now
  end
end
