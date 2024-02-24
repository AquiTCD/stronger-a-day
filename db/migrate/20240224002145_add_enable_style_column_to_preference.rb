class AddEnableStyleColumnToPreference < ActiveRecord::Migration[7.1]
  def change
    add_column :user_preferences, :styled_movements, :boolean, null: false, default: true
  end
end
