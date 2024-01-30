# == Schema Information
#
# Table name: challenges
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  game_id      :bigint           not null
#  character_id :bigint
#  opponent_id  :bigint
#  topic        :string           not null
#  public       :boolean          default(TRUE), not null
#  selected     :boolean          default(FALSE), not null
#  achieved_at  :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_challenges_on_character_id  (character_id)
#  index_challenges_on_game_id       (game_id)
#  index_challenges_on_opponent_id   (opponent_id)
#  index_challenges_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (opponent_id => characters.id)
#  fk_rails_...  (user_id => users.id)
#
class Challenge < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :character, optional: true
  belongs_to :opponent, class_name: "Character", optional: true

  has_many :play_challenges, dependent: :destroy
  has_many :plays, through: :play_challenges

  validates :topic, presence: true

  scope :in_public, -> { where(public: true) }
  scope :in_private, -> { where(public: false) }
  scope :achieved, -> { where.not(achieved_at: nil) }
  scope :not_achieved, -> { where(achieved_at: nil) }
  scope :selected, -> { where(selected: true) }

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
