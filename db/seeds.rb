# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'



image_url = ["https://img.freepik.com/photos-gratuite/pizza-mixte-divers-ingredients_140725-3790.jpg?t=st=1655193419~exp=1655194019~hmac=93d53a026685e0b93926e67a3757f8c6dd62881985a67248882ac0ddb5d9105a&w=1380",]
categories = ["Pizza",
              "Boisson",]
      


  i=1
  5.times do
    User.create(email: "user#{i}@yopmail.com", password:"123456", firstname:Faker::Name.first_name, 
      lastname:Faker::Name.last_name , 
      phone:Faker::PhoneNumber.cell_phone,
      role:"")
      puts"User created"
    i+=1
  end

  i=1
  2.times do
    Restaurant.create(name:Faker::Restaurant.name, 
      street:Faker::Address.street_name, 
      zipcode:Faker::Address.zip_code, 
      city:Faker::Address.city, 
      phone:Faker::PhoneNumber.cell_phone,
      manager:User.first)
    i+=1
    puts "restaurant"
  end

  5.times do
  Category.create(title:categories.sample)
    i+=1
  puts"category created"
  end

  i=1
  5.times do
      Product.create(title:"regina",description:"regina la queen parmi les queens",
      price:Faker::Number.number(digits: 3), image_url:image_url.sample, 
      catchphrase:"Yummy", category:Category.first)
      puts"Product created"
      i+=1
  end

  i=1
  20.times do
    ProductRestaurant.create(restaurant:Restaurant.find(rand(Restaurant.first.id..Restaurant.last.id)), product:Product.find(rand(Product.first.id..Product.last.id)))
    i+=1
    puts"Produit resto"
  end


 5.times do
   Order.create(user:User.find(rand(User.first.id..User.last.id)), total_amount:100, pickup_code:"1")
   puts"order"
  end

  5.times do
    Comment.create(user:User.find(rand(User.first.id..User.last.id)), note:Faker::Number.within(range: 1..10), description:Faker::Quotes::Shakespeare.hamlet_quote,)
    puts"comment"
  end

 i=1
   5.times do
   Cart.create(user:User.find(i))
   i+=1
   puts"cart"
 end

 20.times do
  CartProduct.create(cart:Cart.find(rand(Cart.first.id..Cart.last.id)), product:Product.find(rand(Product.first.id..Product.last.id)), quantity:Faker::Number.within(range: 1..10))
  puts"CartProduct"
end


