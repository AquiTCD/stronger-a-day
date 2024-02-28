class AddReferredCountToRecipes < ActiveRecord::Migration[7.1]
  def self.up
    add_column :recipes, :referred_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :recipes, :referred_count
  end
end
