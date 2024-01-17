class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.references :title, null: false, foreign_key: true

      t.string :name, null: false
      t.string :display_name, null: false
      t.string :kana, null: false

      t.timestamps
    end
  end
end
