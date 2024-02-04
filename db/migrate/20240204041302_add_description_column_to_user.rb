class AddDescriptionColumnToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :description, :string, null: false, default: ""
  end
end
