# == Schema Information
#
# Table name: play_results
#
#  id          :bigint           not null, primary key
#  play_id     :bigint           not null
#  opponent_id :bigint           not null
#  result      :string           not null
#  comment     :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_play_results_on_opponent_id  (opponent_id)
#  index_play_results_on_play_id      (play_id)
#
# Foreign Keys
#
#  fk_rails_...  (opponent_id => characters.id)
#  fk_rails_...  (play_id => plays.id)
#
class Play::Result < ApplicationRecord
  belongs_to :play
  belongs_to :opponent, class_name: "Character"
  has_many :challenge_results, class_name: "Play::ChallengeResult", foreign_key: :play_result_id, dependent: :destroy

  RESULTS = %w[win lose no_contest].freeze
  enum result: RESULTS.zip(RESULTS).to_h
end
