class AddOpeningAndClosingToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :opening, :integer, default: 10
    add_column :restaurants, :closing, :integer, default: 22
  end
end
