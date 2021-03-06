class AddIndexEmailToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
    add_index :users, :email, unique: true
  end
end
