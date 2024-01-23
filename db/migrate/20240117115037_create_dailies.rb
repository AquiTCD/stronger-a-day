class CreateDailies < ActiveRecord::Migration[7.1]
  def change
    create_table :dailies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.date :tried_on, null: false
      t.integer :round, null: false, default: 1
      t.string :status, null: false, default: "ready"

      t.timestamps
    end
  end
end
