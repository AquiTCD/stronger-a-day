class CreateSituations < ActiveRecord::Migration[7.1]
  def change
    create_table :situations do |t|
      t.references :game, null: false, foreign_key: true
      t.string :name, null: false, index: { unique: true }
      t.string :display_name, null: false

      t.timestamps
    end
  end
end
