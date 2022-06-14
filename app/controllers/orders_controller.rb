class OrdersController < ApplicationController
  def index
  end

  def show
  end

  def new
    puts "#"*100
    puts "On est dans la méthode NEW de Orders."
    puts "#"*100

    @order_to_pay = Order.where(user:current_user).last
    puts "#"*100
    puts "order_to_pay = #{@order_to_pay}"
    puts "#"*100


  end

  def create
    
    puts "#"*100
    puts "On est dans la méthode CREATE de Orders."
    puts "#"*100

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
      @current_order.update(pickup_code:"#{@current_order.id}####{@current_order.created_at}")
      puts "#"*100
      puts "On est dans le block STRIPE."
      puts "@current_order = #{@current_order}"
      puts "@current_order.total_amount = #{@current_order.total_amount}"
      puts "@current_order.user.email = #{@current_order.user.email}"
      puts "#"*100
      # Faire une redirection ici ?
      
    rescue Stripe::CardError => e
      flash[:error] = e.message 
      redirect_to new_order_path # initialement : redirect_to new_order_path
    end
    # After the rescue, if the payment succeeded


  end

  def edit
  end

  def update
  end

  def destroy
  end
end
