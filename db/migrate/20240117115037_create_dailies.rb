class CreateDailies < ActiveRecord::Migration[7.1]
  def change
    create_table :dailies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.integer :round, null: false, default: 1

      t.timestamps
    end
  end
end
