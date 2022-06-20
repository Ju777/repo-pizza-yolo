class AddScheduleRefToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :schedule, foreign_key: true
  end
end
