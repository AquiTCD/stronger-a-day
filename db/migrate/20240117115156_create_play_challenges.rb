class CreatePlayChallenges < ActiveRecord::Migration[7.1]
  def change
    create_table :play_challenges do |t|
      t.references :play, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true

      t.timestamps
    end

    add_index :play_challenges, [:play_id, :challenge_id], unique: true
  end
end
