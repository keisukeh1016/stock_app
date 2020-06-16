class AddcolumnCashToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :cash, :float,null: false, default: 100000
  end
end
