# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Faker::Config.locale = :fr

Schedule.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('schedules')
Order.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('orders')
ProductRestaurant.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('product_restaurants')
Restaurant.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('restaurants')
CartProduct.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('cart_products')
Product.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('products')
Category.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('categories')
Cart.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('carts')
Comment.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('comments')
User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')

User.create(email:"pizza-admin@yopmail.com", password:"123456", role:2, firstname:"admin", lastname:"admin")
User.create(email:"pizza-manager@yopmail.com", password:"123456", role:1, firstname:"manager", lastname:"manager")         
i=3
8.times do
  User.create(email:"pizza-user#{i}@yopmail.com", password:"123456")
  i+=1
end

Restaurant.create(name:"PIZZA-YOLO", street:Faker::Address.street_name, zipcode:Faker::Address.zip_code, city:Faker::Address.city, phone:"0110203040", manager:User.second)

Category.create(title:"boisson")
Category.create(title:"dessert")
Category.create(title:"pizza")

i=1
10.times do
  # Schedule.create(date:Time.now + 3600*24*rand(2..10))
  if i.even?
    Schedule.create(date: Time.new(Time.now.year, Time.now.month, rand(Time.now.day..30), rand(10..21), 00))
  else
    Schedule.create(date: Time.new(Time.now.year, Time.now.month, rand(Time.now.day..30), rand(10..21), 30))
  end
  i+=1
end

i=1
20.times do
  Product.create(title:Faker::Food.dish, description:Faker::Food.description, price:Faker::Commerce.price, image_url:"product_#{i}_image.jpg",catchphrase:Faker::Movie.quote, category:Category.find(rand(Category.first.id..Category.last.id)), schedule: Schedule.find(rand(Schedule.first.id..Schedule.last.id))) 
  i+=1
end

20.times do
  ProductRestaurant.create(restaurant:Restaurant.find(rand(Restaurant.first.id..Restaurant.last.id)), product:Product.find(rand(Product.first.id..Product.last.id)))
end

20.times do
  Order.create(total_amount: Faker::Commerce.price, pickup_code:"not_paid", user:User.find(rand(User.first.id..User.last.id)), restaurant: Restaurant.find(rand(Restaurant.first.id..Restaurant.last.id)) )
end

i=1
10.times do
  Comment.create(note:rand(0..5), description:"user's comment n°#{i}", user:User.find(rand(User.first.id..User.last.id)))
  i+=1
end

20.times do
 CartProduct.create(cart:Cart.find(rand(Cart.first.id..Cart.last.id)), product:Product.find(rand(Product.first.id..Product.last.id)), quantity:Faker::Number.within(range: 1..10))
end


