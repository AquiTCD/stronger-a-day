class CreateUserFavoriteCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :user_favorite_characters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.timestamps
    end
    add_index :user_favorite_characters, %i[user_id character_id], unique: true

    add_column :user_preferences, :show_only_favorites, :boolean, null: false, default: true
  end
end
