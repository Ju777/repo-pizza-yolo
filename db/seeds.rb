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

Category.create(title:"pizza")
Category.create(title:"dessert")
Category.create(title:"boisson")



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

title = [
  "Margherita", "Pepperoni", "Quatre Fromages", "Reine", "Forestière", "Gourmet", 
  "Prosciutto", "Provençale", "Orientale", "Maritime", "Carnivore", "Salami", 
  "Marocaine", "Bacon", "Paysanne", "Tiramisu", "Torta di Panna Cotta", 
  "Panettone Gianduja", "San Pellegrino", "Birra Moretti"
]

description = [
  "Ingrédients : Farine italienne, sauce tomate entière, mozarella, tomates, pesto, origan.",
  "Ingrédients : Farine italienne, sauce tomate entière, mozarella, vrai pepperoni italien, piments forts, câpres, origan.",
  "Ingrédients : Farine italienne, sauce à la crème et parmesan, mozzarella, gorgonzola, parmesan, bleu, noix, canneberge.",
  "Ingrédients : Farine italienne, sauce tomate entière, mozzarella, jambon de Paris, champignons, olives, origan.",
  "Ingrédients : Farine italienne, sauce aux truffes, mozarella, cèpes, girolles, morilles, oignons doux, ciboulette.",
  "Ingrédients : Farine italienne, sauce tomate entière, mozarella, magret de canard, sauce secrète, noix, poireau, concombre, coriandre.",
  "Ingrédients : Farine italienne, sauce tomate entière, mozarella, prosciutto, roquette, tomates cerises, tomates séchées, origan, parmesan.",
  "Ingrédients : Farine italienne, sauce tomate entière, mozarella, agneau, aubergines au four, sauce secrète, oignon doux, basilic.",
  "Ingrédients : Farine italienne, sauce tomate entière, mozarella, pepperoni, merguez, poivrons, olives, sauce pesto, oeuf, origan.",
  "Ingrédients : Farine italienne, sauce tomate entière, mozarella, saumon fumé, tomates, épinards, bleu, ail, citron, pignons, olives, origan.",
  "Ingrédients : Farine italienne, sauce tomate entière, mozarella, boeuf, saucisse de porc, pepperoni, merguez, poivrons, oignons rouges, sauce barbecue, origan.",
  "Ingrédients : Farine italienne, sauce tomate entière, mozarella, salami de qualité, origan.",
  "Ingrédients : Farine italienne, sauce aux truffes, mozarella, agneau tranché grillé, figues, brie, amandes, sauce grenade.",
  "Ingrédients : Farine italienne, sauce tomate entière, mozarella, bacon grillé, gorgonzola, piment, origan.",
  "Ingrédients : Farine italienne, sauce à la crème et parmesan, mozarella, bleu, poulet grillé, champignons, poivrons, origan.",
  "Le grand classique : mascarpone, oeufs, café noir non sucré, cacao amer, biscuits, sucre vanillé.",
  "Délicieuse Pana Cotta en tartelette, à la vanille, nectarine, fraise et framboise.",
  "Panettonne au Gianduja (chocolat) et à la noisette. Je n'en dirai pas plus, j'en ai déjà trop dit...",
  "N'est pas vendue avec le verre...",
  "À consommer avec modération."
]

 price = [ 11.99, 12.99, 13.99, 12.99, 14.99, 14.99, 13.99, 13.99, 12.99, 14.99,
  13.99, 11.99, 13.99, 12.99, 12.99, 6.99, 6.99, 7.99, 2.99, 3.99
]

catchphrase = [ "La classique", "Attention, ça pique !", "Toujours plus de fromages", "God save the Queen", "Petite balade en forêt", 
"La pizza étoilée", "Le meilleur jambon italien", "Il est où le magneau ?", "La classique qui pique", "Séjour à la mer",
"Pour les viandards", "La pizza sous-cotée", "Ma nouvelle préférée", "Une odeur merveilleuse", "Future classique",
"La transition parfaite", "Légèreté idéale", "Secret de grand-mère", "Bien mieux que le Perrier", "Après l'effort"
]

  Product.create(title:title[0], description:description[0], price:price[0], image_url:"product_#{1}_image.png", catchphrase:catchphrase[0], category:Category.first)
  Product.create(title:title[1], description:description[1], price:price[1], image_url:"product_#{2}_image.png", catchphrase:catchphrase[1], category:Category.first)
  Product.create(title:title[2], description:description[2], price:price[2], image_url:"product_#{3}_image.png", catchphrase:catchphrase[2], category:Category.first)
  Product.create(title:title[3], description:description[3], price:price[3], image_url:"product_#{4}_image.png", catchphrase:catchphrase[3], category:Category.first)
  Product.create(title:title[4], description:description[4], price:price[4], image_url:"product_#{5}_image.png", catchphrase:catchphrase[4], category:Category.first)
  Product.create(title:title[5], description:description[5], price:price[5], image_url:"product_#{6}_image.png", catchphrase:catchphrase[5], category:Category.first)
  Product.create(title:title[6], description:description[6], price:price[6], image_url:"product_#{7}_image.png", catchphrase:catchphrase[6], category:Category.first)
  Product.create(title:title[7], description:description[7], price:price[7], image_url:"product_#{8}_image.png", catchphrase:catchphrase[7], category:Category.first)
  Product.create(title:title[8], description:description[8], price:price[8], image_url:"product_#{9}_image.png", catchphrase:catchphrase[8], category:Category.first)
  Product.create(title:title[9], description:description[9], price:price[9], image_url:"product_#{10}_image.png", catchphrase:catchphrase[9], category:Category.first)
  Product.create(title:title[10], description:description[10], price:price[10], image_url:"product_#{11}_image.png", catchphrase:catchphrase[10], category:Category.first)
  Product.create(title:title[11], description:description[11], price:price[11], image_url:"product_#{12}_image.png", catchphrase:catchphrase[11], category:Category.first)
  Product.create(title:title[12], description:description[12], price:price[12], image_url:"product_#{13}_image.png", catchphrase:catchphrase[12], category:Category.first)
  Product.create(title:title[13], description:description[13], price:price[13], image_url:"product_#{14}_image.png", catchphrase:catchphrase[13], category:Category.first)
  Product.create(title:title[14], description:description[14], price:price[14], image_url:"product_#{15}_image.png", catchphrase:catchphrase[14], category:Category.first)
  Product.create(title:title[15], description:description[15], price:price[15], image_url:"product_#{16}_image.png", catchphrase:catchphrase[15], category:Category.second)
  Product.create(title:title[16], description:description[16], price:price[16], image_url:"product_#{17}_image.png", catchphrase:catchphrase[16], category:Category.second)
  Product.create(title:title[17], description:description[17], price:price[17], image_url:"product_#{18}_image.png", catchphrase:catchphrase[17], category:Category.second)
  Product.create(title:title[18], description:description[18], price:price[18], image_url:"product_#{19}_image.png", catchphrase:catchphrase[18], category:Category.third)
  Product.create(title:title[19], description:description[19], price:price[19], image_url:"product_#{20}_image.png", catchphrase:catchphrase[19], category:Category.third)

  puts "Created #{Product.count} products"

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
 CartProduct.create(cart:Cart.find(rand(Cart.first.id..Cart.last.id)), product:Product.find(rand(Product.first.id..Product.last.id)), quantity:Faker::Number.within(range: 1..10), schedule: Schedule.find(rand(Schedule.first.id..Schedule.last.id)))
end


