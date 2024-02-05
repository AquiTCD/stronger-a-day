# == Schema Information
#
# Table name: play_challenges
#
#  id           :bigint           not null, primary key
#  play_id      :bigint           not null
#  challenge_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_play_challenges_on_challenge_id  (challenge_id)
#  index_play_challenges_on_play_id       (play_id)
#
# Foreign Keys
#
#  fk_rails_...  (challenge_id => challenges.id)
#  fk_rails_...  (play_id => plays.id)
#
class Play::Challenge < ApplicationRecord
  belongs_to :play
  belongs_to :challenge, class_name: "::Challenge"

  validates :challenge_id, uniqueness: { scope: :play_id }
end
