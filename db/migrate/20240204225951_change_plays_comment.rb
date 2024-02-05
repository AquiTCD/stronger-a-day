class ChangePlaysComment < ActiveRecord::Migration[7.1]
  def up
    change_column :plays, :comment, :string, default: "", null: false
  end

  def down
    change_column :plays, :comment, :text, default: "", null: false
  end
end
