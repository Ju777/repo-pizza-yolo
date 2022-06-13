class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :phone
      t.references :manager, index: true
      
      t.timestamps
    end
  end
end
