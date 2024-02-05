# == Schema Information
#
# Table name: play_challenge_results
#
#  id             :bigint           not null, primary key
#  play_result_id :bigint           not null
#  challenge_id   :bigint           not null
#  result         :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  idx_on_play_result_id_challenge_id_beb5077770   (play_result_id,challenge_id) UNIQUE
#  index_play_challenge_results_on_challenge_id    (challenge_id)
#  index_play_challenge_results_on_play_result_id  (play_result_id)
#
# Foreign Keys
#
#  fk_rails_...  (challenge_id => challenges.id)
#  fk_rails_...  (play_result_id => play_results.id)
#
class Play::ChallengeResult < ApplicationRecord
  belongs_to :play_result, class_name: "Play::Result"
  belongs_to :challenge, class_name: "::Challenge"

  validates :challenge_id, uniqueness: { scope: :play_result_id }

  RESULTS = %w[success failure].freeze
  enum result: RESULTS.zip(RESULTS).to_h
end
