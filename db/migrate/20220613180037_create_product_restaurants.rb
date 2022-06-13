class CreateProductRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :product_restaurants do |t|

      t.timestamps
    end
  end
end
