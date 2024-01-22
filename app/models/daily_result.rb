# == Schema Information
#
# Table name: daily_results
#
#  id          :bigint           not null, primary key
#  daily_id    :bigint           not null
#  opponent_id :bigint           not null
#  win_count   :integer          default(0), not null
#  lose_count  :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_daily_results_on_daily_id                  (daily_id)
#  index_daily_results_on_daily_id_and_opponent_id  (daily_id,opponent_id) UNIQUE
#  index_daily_results_on_opponent_id               (opponent_id)
#
# Foreign Keys
#
#  fk_rails_...  (daily_id => dailies.id)
#  fk_rails_...  (opponent_id => characters.id)
#
class DailyResult < ApplicationRecord
  belongs_to :daily
  belongs_to :opponent, class_name: "Character"

  validates :opponent_id, uniqueness: { scope: :daily_id }
end
