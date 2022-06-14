# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
Faker::Config.locale = :fr

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
Order.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('orders')
User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')

i=1
10.times do
  User.create(email:"pizza-user#{i}@yopmail.com", password:"123456", phone:"0607080910")
  i+=1
end

3.times do
  Category.create(title:Faker::Fantasy::Tolkien.race)
end

i=1
20.times do
  Product.create(title:Faker::Food.dish, description:Faker::Food.description, price:Faker::Commerce.price, image_url:"product_#{i}_image.jpg",catchphrase:Faker::Movie.quote, category:Category.find(rand(Category.first.id..Category.last.id))) 
  i+=1
end

10.times do
  CartProduct.create(cart:Cart.find(rand(Cart.first.id..Cart.last.id)), product:Product.find(rand(Product.first.id..Product.last.id)), quantity:rand(0..10))
end

10.times do
  Order.create(total_amount: Faker::Commerce.price, pickup_code:"-", user:User.find(rand(User.first.id..User.last.id)))
end

10.times do
  Comment.create(note:rand(0..5), description:"a user's comment", user:User.find(rand(User.first.id..User.last.id)))
end

5.times do
  Restaurant.create(name:Faker::Movie.title, street:Faker::Address.street_name, zipcode:rand(10000..99999), city:Faker::Address.city, phone:"0607080910", manager:User.find(rand(User.first.id..User.last.id)))
end