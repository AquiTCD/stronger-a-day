class CreateDailyResults < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_results do |t|
      t.references :daily, null: false, foreign_key: true
      t.references :opponent, null: false, foreign_key: { to_table: :characters }

      t.integer :win_count, null: false, default: 0
      t.integer :lose_count, null: false, default: 0

      t.timestamps
    end
  end
end