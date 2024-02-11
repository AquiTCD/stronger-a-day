class CreateRecipeSituations < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_situations do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :situation, null: false, foreign_key: true
      t.timestamps
    end

    # add_index :recipe_situations, [:recipe_id, :situation_id], unique: true
  end
end
