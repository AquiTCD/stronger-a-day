# == Schema Information
#
# Table name: challenges
#
#  id           :bigint           not null, primary key
#  private      :boolean          default(FALSE), not null
#  topic        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :bigint
#  opponent_id  :bigint
#  title_id     :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_challenges_on_character_id  (character_id)
#  index_challenges_on_opponent_id   (opponent_id)
#  index_challenges_on_title_id      (title_id)
#  index_challenges_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#  fk_rails_...  (opponent_id => characters.id)
#  fk_rails_...  (title_id => titles.id)
#  fk_rails_...  (user_id => users.id)
#
class Challenge < ApplicationRecord
  belongs_to :user
  belongs_to :title
  belongs_to :character, optional: true
  belongs_to :opponent, class_name: "Character", optional: true

  has_many :daily_challenges, dependent: :destroy
  has_many :dailies, through: :daily_challenges

  has_many :daily_results, dependent: :destroy
  has_many :daily_opponents, through: :daily_results, source: :opponent

  validates :topic, presence: true

  scope :public_challenges, -> { where(private: false) }
  scope :private_challenges, -> { where(private: true) }

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