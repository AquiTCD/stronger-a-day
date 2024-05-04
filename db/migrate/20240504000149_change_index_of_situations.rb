class ChangeIndexOfSituations < ActiveRecord::Migration[7.1]
  def change
    remove_index :situations, :name, unique: true
    add_index :situations, [:game_id, :name], unique: true
  end
end
