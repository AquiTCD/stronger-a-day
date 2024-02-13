# == Schema Information
#
# Table name: trainings
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  game_id      :bigint           not null
#  recipe_id    :bigint
#  character_id :bigint
#  topic        :string           not null
#  public       :boolean          default(TRUE), not null
#  achieved_at  :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_trainings_on_character_id  (character_id)
#  index_trainings_on_game_id       (game_id)
#  index_trainings_on_recipe_id     (recipe_id)
#  index_trainings_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (recipe_id => recipes.id)
#  fk_rails_...  (user_id => users.id)
#
class Training < ApplicationRecord
  def self.table_name_prefix
    (self == Training) ? "" : "training_"
  end

  belongs_to :user
  belongs_to :game
  belongs_to :character, optional: true
  belongs_to :recipe, optional: true
  has_many :results, class_name: "Training::Result", dependent: :destroy

  scope :in_public, -> { where(public: true) }
  scope :in_private, -> { where(public: false) }
  scope :achieved, -> { where.not(achieved_at: nil) }
  scope :not_achieved, -> { where(achieved_at: nil) }

  def achieved?
    achieved_at.present?
  end
end
