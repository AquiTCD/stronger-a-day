class CreateTrainingResults < ActiveRecord::Migration[7.1]
  def change
    create_table :training_results do |t|
      t.references :training, null: false, foreign_key: true

      t.string :comment

      t.timestamps
    end
  end
end
