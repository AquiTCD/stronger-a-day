class CreateChallenges < ActiveRecord::Migration[7.1]
  def change
    create_table :challenges do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.references :character, null: true, foreign_key: true
      t.references :opponent, null: true, foreign_key: { to_table: :characters }

      t.string :topic, null: false
      t.boolean :private, null: false, default: false

      t.timestamps
    end
  end
end
