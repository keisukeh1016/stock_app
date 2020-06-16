class RemoveColumnDodChangeFromStocks < ActiveRecord::Migration[6.0]
  def change
    remove_index :stocks, :dod_change
    remove_column :stocks, :dod_change, :float, null: false, default: 0
  end
end
