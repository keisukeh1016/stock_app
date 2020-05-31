class ChangePrimaryKeyStocksToCode < ActiveRecord::Migration[6.0]
  def change
    change_table :stocks, primary_key: :code  do |t|
    remove_column :stocks, :id, :integer
    end
  end
end
