class AddColumnDodChangeToStocks < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :dod_change, :float, null: false, default: 0.0
  end
end
