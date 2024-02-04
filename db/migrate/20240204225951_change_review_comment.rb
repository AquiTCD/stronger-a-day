class ChangeReviewComment < ActiveRecord::Migration[7.1]
  def change
    change_column(:play_results, :comment, :string, default: "", null: false)
  end
end
