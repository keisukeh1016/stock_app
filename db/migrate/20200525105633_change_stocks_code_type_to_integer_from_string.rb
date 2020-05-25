class ChangeStocksCodeTypeToIntegerFromString < ActiveRecord::Migration[6.0]
  def up
    execute "ALTER TABLE stocks ALTER code TYPE integer USING code::integer;"
  end

  def down
    change_column :stocks, :code, :string
  end
end
