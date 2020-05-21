class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
