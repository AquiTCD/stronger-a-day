# == Schema Information
#
# Table name: dailies
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  character_id :bigint           not null
#  round        :integer          default(1), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_dailies_on_character_id  (character_id)
#  index_dailies_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#  fk_rails_...  (user_id => users.id)
#
class Daily < ApplicationRecord
  belongs_to :user
  belongs_to :character
  has_many :daily_challenges, dependent: :destroy
  has_many :challenges, through: :daily_challenges
  has_many :daily_results, dependent: :destroy
end
