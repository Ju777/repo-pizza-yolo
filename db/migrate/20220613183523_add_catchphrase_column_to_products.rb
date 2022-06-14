class AddCatchphraseColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :catchphrase, :string
  end
end
