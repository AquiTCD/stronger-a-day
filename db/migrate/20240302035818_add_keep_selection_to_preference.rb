class AddKeepSelectionToPreference < ActiveRecord::Migration[7.1]
  def change
    add_column :user_preferences, :keep_selection, :boolean, null: false, default: true
  end
end
