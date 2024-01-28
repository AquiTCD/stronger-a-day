class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :title, null: false, index: { unique: true }
      t.string :abbreviation, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
