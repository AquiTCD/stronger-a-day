# == Schema Information
#
# Table name: plays
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  character_id :bigint           not null
#  started_at   :datetime         not null
#  status       :string           default("ready"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_plays_on_character_id  (character_id)
#  index_plays_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#  fk_rails_...  (user_id => users.id)
#
class Play < ApplicationRecord
  def self.table_name_prefix
    (self == Play) ? "" : "play_"
  end
  belongs_to :user
  belongs_to :character
  has_many :play_challenges, dependent: :destroy
  has_many :challenges, through: :play_challenges
  has_many :play_results, dependent: :destroy

  attribute :started_at, :datetime, default: -> { Time.current }

  STATUSES = %w[ready in_progress finished reviewed].freeze

  enum status: STATUSES.zip(STATUSES).to_h
end
