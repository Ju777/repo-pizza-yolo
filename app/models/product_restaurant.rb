class ProductRestaurant < ApplicationRecord
  belongs_to :restaurant
  belongs_to :product
end
