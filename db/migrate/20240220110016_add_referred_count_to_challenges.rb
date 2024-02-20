class AddReferredCountToChallenges < ActiveRecord::Migration[7.1]
  def self.up
    add_column :challenges, :referred_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :challenges, :referred_count
  end
end
