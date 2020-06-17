class AddColumnHoldingToPortfolios < ActiveRecord::Migration[6.0]
  def change
    add_column :portfolios, :holding, :integer, null: false, default: 1
  end
end
