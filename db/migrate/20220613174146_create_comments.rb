class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.decimal :note
      t.text :description

      t.timestamps
    end
  end
end
