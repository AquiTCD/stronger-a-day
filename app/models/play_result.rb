# == Schema Information
#
# Table name: play_results
#
#  id          :bigint           not null, primary key
#  play_id     :bigint           not null
#  opponent_id :bigint           not null
#  win_count   :integer          default(0), not null
#  lose_count  :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_play_results_on_opponent_id              (opponent_id)
#  index_play_results_on_play_id                  (play_id)
#  index_play_results_on_play_id_and_opponent_id  (play_id,opponent_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (opponent_id => characters.id)
#  fk_rails_...  (play_id => plays.id)
#
class PlayResult < ApplicationRecord
  belongs_to :play
  belongs_to :opponent, class_name: "Character"

  validates :opponent_id, uniqueness: { scope: :play_id }
end
