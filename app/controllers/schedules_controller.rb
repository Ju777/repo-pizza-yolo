class SchedulesController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    puts "#"*100
    puts "#"*100
    puts "BIENVENUE DANS LA MÉTHODE Schedule#create."
    puts "Voici le params = #{params.inspect}"
    puts "#"*100
    puts "#"*100

    # Commencons par transformer la saisie en éléments exploitables par le model Schedule.
    selected_date = params_to_time
    # Déterminons maintenant combien de pizzas nous devons préparés dans ce cart_product.
    remaining_pizzas = pizzas_to_cook
    # Lançons nous dans la recherche d'horaires disponibles pour préparer ces pizzas à l'horaire demandé.
    while(search_schedule(remaining_pizzas, selected_date) > 0)
      puts "#"*100
      puts "Début de la boucle while, il y a #{remaining_pizzas} pizzas à caser :"
      puts "#"*100
      search_schedule(remaining_pizzas, selected_date)
    end






    # En fin de recherche d'horaires pour les pizzas, il faudra lier les produits non cuisinables de cette commande au même horaire que celui des pizzas.


    redirect_to cart_path(current_user.cart)
  end

  def edit
  end

  def update
  end

  def destroy
  end

private

  def params_to_time
    split_1 = params[:date].split("-")
    split_2 = split_1[2].split("T")
    split_3 = split_2[1].split(":")

    @day = split_2[0].to_i
    @month = split_1[1].to_i
    @year = split_1[0].to_i
    @hour = split_2[1].to_i
    @min = split_3[1].to_i
    # Ajustement de @min vers la demi-heure précédente la plus proche.
    @min = 0 if @min < 30
    @min = 30 if @min >= 30

    time_object = Time.new(@year, @month, @day, @hour + 2, @min).getutc # +2 sur l'heure -> pour compenser le décalage de timezone.
    puts "#"*100
    puts "Les éléments extraits de la saisie sont => le #{@day}/#{@month}/#{@year} à #{@hour} heures et #{@min} minutes."
    puts "La transformation a donné : time_object = Time.new(@year, @month, @day, @hour).getutc => #{time_object}."
    puts "#"*100

    return time_object
  end

  def pizzas_to_cook
    puts "#"*100
    puts "ENTREE DANS la méthode calcul des pizzas_to_cook."
    puts "#"*100
    pizzas_quantity = 0
    current_user.cart.cart_products.each do |cart_product|
      if cart_product.product.category.title == "pizza"
        puts "#"*100
        puts "Ce cart product contient #{cart_product.quantity} #{cart_product.product.title} affectée au créneau #{cart_product.schedule.date}."
        puts "#"*100
        pizzas_quantity += cart_product.quantity
      end
    end

    puts "#"*100
    puts "Le calcul nous dit : #{pizzas_quantity} pizzas à préparer. Vérifie ce chiffre par rapport au panier."
    puts "#"*100

    return pizzas_quantity
  end

  def is_schedule_existing(time_object)
    puts "#"*100
    puts "Méthode is_schedule_existing(time_object). L'objet passé en paramètre est #{time_object}."
    puts "Tous les Schedule en base sont :"
    Schedule.all.each do |schedule|
      puts "#{schedule.id}. #{schedule} => #{schedule.date}"
      if schedule.date == time_object
        puts "CA MATCH !"
      else
        puts "CA MATCH PAS !"
      end
    end
    puts "#"*100

    puts "#"*100
    puts "Y trouvons-nous l'horaire choisi par l'utilisateur ?"
    selected_schedule = Schedule.find_by(date: time_object)
    unless selected_schedule == nil
      puts "Oui ! C'est le n° #{selected_schedule.id}. Vérifie plus haut."
      return selected_schedule
    else
      puts "Non, je ne le trouve pas, vérifie plus haut. Il faut donc le créer. "
      return false
    end
    puts "#"*100
  end

  def search_schedule(remaining_pizzas, params_to_time)
    puts "#"*100
    puts "Ca y'est on démarre la recherche d'horaire disponible pour donner #{remaining_pizzas} pizzas (normalement pour le #{params_to_time})."
    puts "Déjà, est-ce que l'horaire demandé par l'utilisateur existe ? S'il n'existe pas on va le créer." 
    puts "#"*100
    schedule_state = is_schedule_existing(params_to_time)
    unless schedule_state
      selected_schedule = Schedule.create(date: params_to_time)
    puts "#"*100
    puts "Voici ce que j'ai créé => selected_schedule = #{selected_schedule} => #{selected_schedule.date}. Si c'est bon, on continue."
    puts "#"*100
    else
      selected_schedule = schedule_state
      puts "#"*100
      puts "Je ne le crée donc pas, on continue."
      puts "#"*100
    end

    puts "#"*100
    puts "Maintenant qu'on a un créneau bien créé, y'a-t-il assez de place pour cuisiner #{remaining_pizzas} pizzas ? Rappelons que la capacité max de cette pizzeria est est #{Restaurant.first.cooking_capacity} pizzas par créneau de 30 min."
    puts "#"*100

    available_places = how_much_places(selected_schedule, remaining_pizzas)
    has_enough_places(available_places, remaining_pizzas)

    update_user_cart_schedules(selected_schedule, remaining_pizzas, available_places)

    remaining_pizzas = 0
    return remaining_pizzas

    
  end

  def how_much_places(selected_schedule, remaining_pizzas)
    cart_products = selected_schedule.cart_products
    already_ordered_pizzas = 0

    cart_products.each do |cart_product|
      puts "Dans le ProduitPanier #{cart_product.product.title} => il y a #{cart_product.quantity} #{cart_product.product.category.title}"
      if cart_product.product.category.title == "pizza"
        already_ordered_pizzas += cart_product.quantity
      end
    end

    available_places = Restaurant.first.cooking_capacity - already_ordered_pizzas

    puts "#"*100
    puts "Il y a déjà #{already_ordered_pizzas} pizzas sur ce créneau on veut en ajouter #{remaining_pizzas}."
    puts "#"*100
    return available_places
  end

  def has_enough_places(available_places, remaining_pizzas)
    if available_places >= remaining_pizzas
      puts "#"*100
      puts "Y'A ASSEZ DE PLACES."
      puts "#"*100
      return true
    else
      puts "#"*100
      puts "Y'A PAS ASSEZ DE PLACES"
      puts "#"*100
      return false
    end

  end

  def update_user_cart_schedules(selected_schedule, remaining_pizzas, available_places)
    puts "#"*100
    puts "ENTREE DANS L'UPDATE avec le créneau choisi : on est dans la véritable phase de réservation des cart_product."
    puts "Le principe c'est que l'on va caser les pizzas jusqu'a ce qu'il n'y ait plus de places disponibles."
    puts "Une fois cette action de faire, on sort de cette méthode, et la méthode principale prendra le relais : elle bouclera sur elle même avec le créneau suivant et le nombre restant de pizzas à préparer"
    puts "#"*100

    puts "#"*100
    puts "De quoi j'ai besoin pour commencer : de tous les cart_products du current_user (qui sont associés à un horaire factice de 1900 ou à peu près."
    puts "Les voici : all_cart_products = current_user.cart.cart_products.each :."
    all_cart_products = current_user.cart.cart_products
    all_cart_products.each do |cart_product|
      puts "#{cart_product.id} : #{cart_product.product.title} => #{cart_product.schedule.date}."
      if cart_product.product.category.title == "pizza"
        puts "Ce cart_product contient #{cart_product.quantity} #{cart_product.product.category.title} à caser dans le créneau sélectionné."
        cart_product.update(schedule:selected_schedule)
        puts "C'est fait. Vérification cart_product.schedule.date = #{cart_product.schedule.date}."
        remaining_pizzas -= cart_product.quantity
        puts "Il reste à caser #{remaining_pizzas} pizzas."
      end
    end
    puts "#"*100
  end
end
