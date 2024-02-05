class CreateChallengeResults < ActiveRecord::Migration[7.1]
  def change
    create_table :play_challenge_results do |t|
      t.references :play_result, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true

      t.string :result, null: false

      t.timestamps
    end

    add_index :play_challenge_results, [:play_result_id, :challenge_id], unique: true
  end
end
