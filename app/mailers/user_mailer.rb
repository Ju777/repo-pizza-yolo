class UserMailer < ApplicationMailer
  default from: 'pizza.yolo.thp@gmail.com'
 
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://git.heroku.com/pizza-yolo.git/' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end


  # email au client pour confirmer sa commande payée
  def customer_order_email(order)
    #on récupère l'instance de la commande en question
    @order = order

    #on declare une variable user pour identifier celui de la commande
    @user = @order.user

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://git.heroku.com/pizza-yolo.git/' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @order.user.email, subject: 'PIZZA-YOLO: Récapitulatif de votre commande') 
  end


  # email au manager du restaurant pour indiquer qu'une commande vient d'être passée/payée
  def pizzeria_order_email(order)
    #on récupère l'instance de la commande en question
    @order = order

    #on défini une variable qui identifie le manager du restaurant lié à la commande
    @admin_user = @order.restaurant.manager

    #on recupere dans une variable le nom du user ayant passé commande
    @order_user_name = "#{@order.user.firstname} #{@order.user.lastname}" 

    mail(to: @admin_email, subject: "Une commande vient d\'passée par #{@order_user_name}" + " !")
  end


end