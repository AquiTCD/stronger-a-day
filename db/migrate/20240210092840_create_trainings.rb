class CreateTrainings < ActiveRecord::Migration[7.1]
  def change
    create_table :trainings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.references :recipe, null: true, foreign_key: true
      t.references :character, null: true, foreign_key: true

      t.string :topic, null: false

      t.boolean :public, null: false, default: true

      t.datetime :achieved_at, null: true
      t.timestamps
    end
  end
end
