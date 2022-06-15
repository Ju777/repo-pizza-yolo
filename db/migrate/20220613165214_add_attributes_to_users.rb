class AddAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstname, :string, default: ""
    add_column :users, :lastname, :string, default: ""
    add_column :users, :phone, :string, default: "0600000000"
  end
end
