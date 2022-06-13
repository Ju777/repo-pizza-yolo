class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.decimal :total_amount
      t.string :pickup_code

      t.timestamps
    end
  end
end
