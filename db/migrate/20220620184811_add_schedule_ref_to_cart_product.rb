class AddScheduleRefToCartProduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_products, :schedule, foreign_key: true
  end
end
