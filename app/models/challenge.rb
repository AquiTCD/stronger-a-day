# == Schema Information
#
# Table name: challenges
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  game_id     :bigint           not null
#  opponent_id :bigint
#  topic       :string           not null
#  private     :boolean          default(FALSE), not null
#  in_progress :boolean          default(FALSE), not null
#  achieved_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_challenges_on_game_id      (game_id)
#  index_challenges_on_opponent_id  (opponent_id)
#  index_challenges_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (opponent_id => characters.id)
#  fk_rails_...  (user_id => users.id)
#
class Challenge < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :opponent, class_name: "Character", optional: true

  has_many :daily_challenges, dependent: :destroy
  has_many :dailies, through: :daily_challenges

  validates :topic, presence: true

  scope :only_public, -> { where(private: false) }
  scope :only_private, -> { where(private: true) }
  scope :achieved, -> { where.not(achieved: null) }

  def achieved?
    achieved_at.present?
  end

  # def daily_opponent_win_rate(user)
  #   return 0 if daily_opponent_result(user).nil?
  #   return 0 if daily_opponent_result(user).win_count.zero? && daily_opponent_result(user).lose_count.zero?

  #   daily_opponent_result(user).win_count.to_f / (daily_opponent_result(user).win_count + daily_opponent_result(user).lose_count)
  # end

  # def daily_opponent_win_rate_percentage(user)
  #   daily_opponent_win_rate(user) * 100
  # end

  # def daily_opponent_win_rate_percentage_string(user)
  #   "#{daily_opponent_win_rate_percentage(user).round(1)}%"
  # end
end
