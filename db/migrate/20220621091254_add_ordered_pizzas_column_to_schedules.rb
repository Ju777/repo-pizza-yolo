class AddOrderedPizzasColumnToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :ordered_pizzas, :integer, default: 0
  end
end
