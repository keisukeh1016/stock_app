class RemoveColumnCashFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :cash
  end
end
