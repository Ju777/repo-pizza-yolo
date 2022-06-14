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


  def order_recap_email(order)
    #on récupère l'instance de la commande en question
    @order = order

    #on declare une variable user pour identifier celui de la commande
    @user = @order.user

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'https://git.heroku.com/pizza-yolo.git/' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @order.user.email, subject: 'PIZZA-YOLO: Récapitulatif de votre commande') 
  end

end
