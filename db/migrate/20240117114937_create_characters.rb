class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.references :game, null: false, foreign_key: true

      t.string :name, null: false, index: { unique: true }
      t.string :display_name, null: false
      t.string :kana, null: false

      t.timestamps
    end
  end
end
