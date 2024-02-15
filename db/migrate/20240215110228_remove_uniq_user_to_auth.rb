class RemoveUniqUserToAuth < ActiveRecord::Migration[7.1]
  def change
    remove_index :user_authentications, :user_id, unique: true
    add_index :user_authentications, [:provider, :user_id], unique: true
  end
end
