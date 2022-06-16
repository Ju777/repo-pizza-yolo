class UserMailer < ApplicationMailer
  default from: 'pizza.yolo.thp@gmail.com'
 
  def welcome_email(user)
    @user = user 
    @url  = 'https://git.heroku.com/pizza-yolo.git/' 
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end


  # send a mail confirmation order to user
  def customer_order_email(order)
    @order = order
    @user = @order.user
    @url  = 'https://git.heroku.com/pizza-yolo.git/' 
    mail(to: @order.user.email, subject: 'PIZZA-YOLO: Récapitulatif de votre commande') 
  end


  # send a mail confirmation order to restaurant manager
  def pizzeria_order_email(order)
    @order = order
    @admin_user = @order.restaurant.manager
    @order_user_name = "#{@order.user.firstname} #{@order.user.lastname}" 
    mail(to: @admin_user.email, subject: "Une commande vient d\'passée par #{@order_user_name}" + " !")
  end
end
