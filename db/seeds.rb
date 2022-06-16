# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Faker::Config.locale = :fr

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

image_url = ["https://img.freepik.com/photos-gratuite/pizza-mixte-divers-ingredients_140725-3790.jpg?t=st=1655193419~exp=1655194019~hmac=93d53a026685e0b93926e67a3757f8c6dd62881985a67248882ac0ddb5d9105a&w=1380",]
categories = ["Pizza",
              "Boisson"]

User.create(email:"admin-pizza@yopmail.com", password:"123456", role:2)              
i=2
10.times do
  User.create(email:"pizza-user#{i}@yopmail.com", password:"123456")
  i+=1
end

5.times do
  Restaurant.create(name:Faker::Movie.title, street:Faker::Address.street_name, zipcode:rand(10000..99999), city:Faker::Address.city, phone:"", manager:User.find(rand(User.first.id..User.last.id)))
end

5.times do
Category.create(title:categories.sample)
puts"category created"
end

i=1
20.times do
  Product.create(title:Faker::Food.dish, description:Faker::Food.description, price:Faker::Commerce.price, image_url:"product_#{i}_image.jpg",catchphrase:Faker::Movie.quote, category:Category.find(rand(Category.first.id..Category.last.id))) 
  i+=1
end

20.times do
  ProductRestaurant.create(restaurant:Restaurant.find(rand(Restaurant.first.id..Restaurant.last.id)), product:Product.find(rand(Product.first.id..Product.last.id)))
  puts"Produit resto"
end

20.times do
  Order.create(total_amount: Faker::Commerce.price, pickup_code:"not_paid", user:User.find(rand(User.first.id..User.last.id)), restaurant: Restaurant.find(rand(Restaurant.first.id..Restaurant.last.id)) )
end

10.times do
  Comment.create(note:rand(0..5), description:"a user's comment", user:User.find(rand(User.first.id..User.last.id)))
end


20.times do
 CartProduct.create(cart:Cart.find(rand(Cart.first.id..Cart.last.id)), product:Product.find(rand(Product.first.id..Product.last.id)), quantity:Faker::Number.within(range: 1..10))
 puts"CartProduct"
end

