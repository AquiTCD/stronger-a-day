class CreatePlays < ActiveRecord::Migration[7.1]
  def change
    create_table :plays do |t|
      t.references :user, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.datetime :started_at, null: false
      t.string :status, null: false, default: "ready"

      t.text :comment, null: false, default: ""

      t.timestamps
    end
  end
end
