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
    params_to_time
    # Déterminons maintenant combien de pizzas nous devons préparés dans ce cart_product.
    remaining_pizzas = pizzas_to_cook
    # Lançons nous dans la recherche d'horaires disponibles pour préparer ces pizzas à l'horaire demandé.
    while(search_schedule(remaining_pizzas, params_to_time)> 0)
      search_schedule(remaining_pizzas, params_to_time)
    end






    # En fin de recherche d'horaires pour les pizzas, il faudra lier les produits non cuisinables de cette commande au même horaire que celui des pizzas.

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
    puts "Les éléments extraits sont => le #{@day}/#{@month}/#{@year} à #{@hour} heures et #{@min} minutes."
    puts "La transformation a donné : time_object = Time.new(@year, @month, @day, @hour).getutc => #{time_object}."
    puts "#"*100

    return time_object
  end

  def pizzas_to_cook
    pizzas_quantity = 0
    current_user.cart.cart_products.each do |cart_product|
      if cart_product.product.category.title == "pizza"
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
        puts "Ca matche !"
      else
        puts "Ca matche pas !"
      end
    end
    puts "#"*100

    puts "#"*100
    puts "Y trouvons-nous l'horaire choisi par l'utilisateur ?"
    selected_schedule = Schedule.find_by(date: time_object)
    unless selected_schedule == nil
      puts "Oui ! C'est le n° #{selected_schedule.id}. Vérifie plus haut."
      return true
    else
      puts "Non, je ne le trouve pas. Il faut donc le créer. Vérifie plus haut."
      return false
    end
    puts "#"*100
  end

  def search_schedule(remaining_pizzas, params_to_time)
    puts "#"*100
    puts "Ca y'est on démarre la recherche d'horaire dispo pour donner #{remaining_pizzas} pizzas à livrer pour le #{params_to_time}."
    puts "Déjà, est-ce que l'horaire demandé par l'utilisateur existe ?" 
    puts "#"*100
    unless is_schedule_existing(params_to_time)
      selected_schedule = Schedule.create(date: params_to_time)
    puts "#"*100
    puts "Voici ce que j'ai crée => selected_schedule = #{selected_schedule} => #{selected_schedule.date}. Si c'est bon, on continue."
    puts "#"*100
    else
      puts "#"*100
      puts "Je ne crée donc rien, on continue."
      puts "#"*100
    end
    return 0
  end
end
