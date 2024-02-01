class CreateChallengeReferences < ActiveRecord::Migration[7.1]
  def change
    create_table :challenge_references do |t|
      t.references :from, null: true, foreign_key: { to_table: :challenges }
      t.references :to, null: false, foreign_key: { to_table: :challenges }

      t.timestamps
    end
    add_index :challenge_references, [:from_id, :to_id], unique: true
  end
end
