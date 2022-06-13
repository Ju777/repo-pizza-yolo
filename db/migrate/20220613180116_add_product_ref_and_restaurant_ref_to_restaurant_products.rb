class AddProductRefAndRestaurantRefToRestaurantProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :product_restaurants, :restaurant, foreign_key: true
    add_reference :product_restaurants, :product, foreign_key: true
  end
end
