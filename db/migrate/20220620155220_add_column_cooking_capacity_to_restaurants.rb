class AddColumnCookingCapacityToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :cooking_capacity, :integer, default: 5
  end
end
