class Restaurant < ApplicationRecord
  belongs_to :manager, class_name: "User"
  has_many :product_restaurants
  has_many :products, through: :product_restaurants
end
