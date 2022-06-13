class Product < ApplicationRecord
  has_many :cart_products
  has_many :carts, through: :cart_products
  belongs_to :category
  has_many :product_restaurants
  has_many :restaurants, through: :product_restaurants
end
