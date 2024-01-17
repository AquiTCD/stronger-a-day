class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :title, null: false, foreign_key: true

      t.text :content, null: true

      t.timestamps
    end
  end
end