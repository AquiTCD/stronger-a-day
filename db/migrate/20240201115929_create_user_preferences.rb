class CreateUserPreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :user_preferences do |t|
      t.references :user, null: false, foreign_key: true

      t.boolean :public, null: false, default: true
      t.boolean :show_usage, null: false, default: true
      t.boolean :show_tips, null: false, default: true

      t.timestamps
    end
  end
end