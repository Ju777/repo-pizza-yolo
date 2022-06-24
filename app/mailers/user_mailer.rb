class UserMailer < ApplicationMailer
  default from: 'pizza.yolo.thp@gmail.com'
 
  def welcome_email(user)
    @user = user 
    @url  = 'https://pizza-yolo.herokuapp.com/' 
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def customer_order_email(order)
    @order = order
    @user = @order.user
    @url  = 'https://pizza-yolo.herokuapp.com/' 
    mail(to: @order.user.email, subject: 'PIZZA-YOLO: Récapitulatif de votre commande') 
  end

  def pizzeria_order_email(order)
    @order = order
    @admin_user = @order.restaurant.manager
    @order_user_name = "#{@order.user.firstname} #{@order.user.lastname}" 
    mail(to: @admin_user.email, subject: "Une commande vient d\'être passée par #{@order_user_name}" + " !")
  end
end
