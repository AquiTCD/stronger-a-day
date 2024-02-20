class AddColumnDefaultPublicToPreference < ActiveRecord::Migration[7.1]
  def change
    add_column :user_preferences, :default_public, :boolean, null: false, default: true
  end
end
