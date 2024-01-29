class CreatePlayResults < ActiveRecord::Migration[7.1]
  def change
    create_table :play_results do |t|
      t.references :play, null: false, foreign_key: true
      t.references :opponent, null: false, foreign_key: { to_table: :characters }

      t.integer :win_count, null: false, default: 0
      t.integer :lose_count, null: false, default: 0

      t.text :comment, null: false, default: ""

      t.timestamps
    end

    add_index :play_results, [:play_id, :opponent_id], unique: true
  end
end
