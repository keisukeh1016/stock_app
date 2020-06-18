class CreateTableWallet < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.integer :user_id, null: false
      t.index :user_id, unique: true

      t.float :cash, null: false, default: 100000

      t.timestamps
    end
  end
end
