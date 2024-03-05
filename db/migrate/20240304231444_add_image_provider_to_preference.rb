class AddImageProviderToPreference < ActiveRecord::Migration[7.1]
  def change
    add_column :user_preferences, :image_provider, :string, null: true
  end
end
