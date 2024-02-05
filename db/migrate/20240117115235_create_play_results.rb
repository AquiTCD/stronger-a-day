class CreatePlayResults < ActiveRecord::Migration[7.1]
  def change
    create_table :play_results do |t|
      t.references :play, null: false, foreign_key: true
      t.references :opponent, null: false, foreign_key: { to_table: :characters }

      t.string :result, null: false
      t.string :comment, null: false, default: ""

      t.timestamps
    end
  end
end
