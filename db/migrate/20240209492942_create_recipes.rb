class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.references :character, null: false, foreign_key: true
      t.string :movements, null: false

      t.string :comment

      t.boolean :public, null: false, default: true

      t.timestamps
    end
  end
end
