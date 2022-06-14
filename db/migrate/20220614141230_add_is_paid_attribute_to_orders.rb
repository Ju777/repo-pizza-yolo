class AddIsPaidAttributeToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :is_paid, :boolean, default:false
  end
end
