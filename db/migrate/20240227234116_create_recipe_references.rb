class CreateRecipeReferences < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_references do |t|
      t.references :from, null: true, foreign_key: { to_table: :recipes }
      t.references :to, null: false, foreign_key: { to_table: :recipes }

      t.timestamps
    end
    add_index :recipe_references, [:from_id, :to_id], unique: true
  end
end
