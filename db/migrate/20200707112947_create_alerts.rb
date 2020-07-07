class CreateAlerts < ActiveRecord::Migration[6.0]
  def change
    create_table :alerts do |t|
      t.integer :user_id, null: false
      t.integer :stock_code, null: false
      t.string :comparison, null: false
      t.float :price, null: false
      t.boolean :completed, null: false, default: false

      t.timestamps

      t.index :user_id
    end
  end
end
