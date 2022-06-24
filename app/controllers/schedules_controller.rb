class SchedulesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @cart_to_show = current_user.cart
    @total_to_pay = total_cart
    @order = Order.create(total_amount: @total_to_pay, user: current_user, restaurant: Restaurant.first)
    @cart_schedule_state = is_cart_fully_scheduled
  end

  def create
    @cart_to_show = current_user.cart
    @total_to_pay = total_cart
    @order = Order.where(user:current_user).last
    if is_input_empty || !is_input_correct
      flash.notice = "Les horaires valides sont : de 10h à 21h30 du lundi au samedi."
      if @order
        @order.destroy
      end
      redirect_to new_schedule_path
    else
      selected_date = params_to_time
      remaining_pizzas = pizzas_to_cook
      @search_status = "searching"
      
      while(@search_status != "completed" && @search_status != "extra" && @search_status != "rejected")
        search_schedule(remaining_pizzas, selected_date)
      end
    end 
  end

  def edit
  end

  def update
  end

  def destroy
  end


private

  def is_input_empty
    if params[:date] == ""
      return true
    else
      return false
    end
  end

  def is_input_correct
    selected_date = params_to_time
    if selected_date.hour < Restaurant.first.opening || selected_date.hour >= Restaurant.first.closing  || selected_date.sunday? || selected_date < Time.new(Time.now.year, Time.now.month, Time.now.day, Time.now.hour, Time.now.min/30*30)
      return false
    else
      return true
    end
  end

  def params_to_time

    split_1 = params[:date].split("-")
    split_2 = split_1[2].split("T")
    split_3 = split_2[1].split(":")

    day = split_2[0].to_i
    month = split_1[1].to_i
    year = split_1[0].to_i
    hour = split_2[1].to_i
    min = split_3[1].to_i

    min = 0 if min < 30
    min = 30 if min >= 30
     
    time_object = Time.new(year, month, day, hour, min)
    return time_object
  end

  def pizzas_to_cook
    pizzas_quantity = 0
    current_user.cart.cart_products.each do |cart_product|
      if cart_product.product.category.title == "pizza"
        pizzas_quantity += cart_product.quantity
      end
    end
    return pizzas_quantity
  end

  def is_schedule_existing(time_object)
    selected_schedule = Schedule.find_by(date: time_object)
    unless selected_schedule == nil
      return selected_schedule
    else
      return false
    end
  end

  def search_schedule(remaining_pizzas, params_to_time)
    schedule_state = is_schedule_existing(params_to_time)
    unless schedule_state
      selected_schedule = Schedule.create(date: params_to_time)
    else
      selected_schedule = schedule_state
    end
    available_places = how_much_places(selected_schedule)
    update_user_cart_schedules(selected_schedule, remaining_pizzas, available_places)
  end

  def how_much_places(selected_schedule)
    available_places = Restaurant.first.cooking_capacity - selected_schedule.ordered_pizzas
    return available_places
  end

  def has_enough_places(available_places, remaining_pizzas)
    if available_places >= remaining_pizzas
      return true
    else
      return false
    end

  end

  def update_user_cart_schedules(selected_schedule, remaining_pizzas, available_places)
    if has_enough_places(available_places, remaining_pizzas)
      current_user.cart.cart_products.each do |cart_product|
        cart_product.update(schedule: selected_schedule)
      end
      selected_schedule.update(ordered_pizzas: selected_schedule.ordered_pizzas + remaining_pizzas)

      remaining_pizzas = 0
      @search_status = "completed"
      flash.notice = "Horaire validé"
    else
      year = selected_schedule.date.year
      month = selected_schedule.date.month
      day = selected_schedule.date.day
      if selected_schedule.date.min == 0
        hour = selected_schedule.date.hour
        min = 30
      elsif selected_schedule.date.min == 30
        hour = selected_schedule.date.hour + 1
        min = 0
      end

      next_time_object = Time.new(year , month, day, hour, min)

      if next_time_object.hour < Restaurant.first.closing
        selected_schedule.update(ordered_pizzas: Restaurant.first.cooking_capacity)
        remaining_pizzas = remaining_pizzas - available_places
        search_schedule(remaining_pizzas, next_time_object)   
      else
        if selected_schedule.ordered_pizzas >= Restaurant.first.cooking_capacity
          remaining_pizzas = 0
          @search_status = "rejected"
          flash.notice = "Votre commande dépasse notre capacité de préparation."
        else
          current_user.cart.cart_products.each do |cart_product|
            cart_product.update(schedule: selected_schedule)
          end
          selected_schedule.update(ordered_pizzas: selected_schedule.ordered_pizzas + remaining_pizzas)

          remaining_pizzas = 0
          @search_status = "extra"
          flash.notice = "Horaire validé"
        end
      end
    end
  end

  def total_cart
    @cart = current_user.cart
    total = 0
      @cart.cart_products.each do |cart_product|
        total += cart_product.product.price*cart_product.quantity
      end
    return total
  end

  def is_cart_fully_scheduled
    false_count = 0
    current_user.cart.cart_products.each do |cart_product|
      if cart_product.schedule.date.year == 1900
        false_count += 1
      end
    end

    if false_count == 0
      return true
    else
      return false
    end    
  end
end
