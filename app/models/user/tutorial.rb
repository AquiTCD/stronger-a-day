# == Schema Information
#
# Table name: user_tutorials
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  page       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_tutorials_on_user_id           (user_id)
#  index_user_tutorials_on_user_id_and_page  (user_id,page) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class User::Tutorial < ApplicationRecord
  belongs_to :user

  PAGES = %i[
    games-show
    challenges-index
    challenges-new
    results-new
    reviews-index
    socials-show
    trainings-index
    recipes-index
  ].freeze
  enum :page, PAGES.zip(PAGES.map(&:to_s)).to_h

  validates :page, presence: true, inclusion: { in: PAGES.map(&:to_s) }
  validates :page, uniqueness: { scope: :user_id }
end
