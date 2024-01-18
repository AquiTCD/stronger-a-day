# == Schema Information
#
# Table name: daily_challenges
#
#  id            :bigint           not null, primary key
#  daily_id      :bigint           not null
#  challenge_id  :bigint           not null
#  success_count :integer          default(0), not null
#  failure_count :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_daily_challenges_on_challenge_id  (challenge_id)
#  index_daily_challenges_on_daily_id      (daily_id)
#
# Foreign Keys
#
#  fk_rails_...  (challenge_id => challenges.id)
#  fk_rails_...  (daily_id => dailies.id)
#
class DailyChallenge < ApplicationRecord
  belongs_to :daily
  belongs_to :challenge
end
