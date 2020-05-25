class ChangeStockCodeIntegerToString < ActiveRecord::Migration[6.0]
  def up
    change_column :stocks, :code, :string
  end

  def down
    execute "ALTER TABLE stocks ALTER code TYPE integer USING code::integer;"
  end
end
