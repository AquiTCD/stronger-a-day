# == Schema Information
#
# Table name: recipes
#
#  id             :bigint           not null, primary key
#  user_id        :bigint           not null
#  game_id        :bigint           not null
#  character_id   :bigint           not null
#  movements      :string           not null
#  comment        :string
#  public         :boolean          default(TRUE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  referred_count :integer          default(0), not null
#
# Indexes
#
#  index_recipes_on_character_id  (character_id)
#  index_recipes_on_game_id       (game_id)
#  index_recipes_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (user_id => users.id)
#
class Recipe < ApplicationRecord
  def self.table_name_prefix
    (self == Recipe) ? "" : "recipe_"
  end

  belongs_to :user
  belongs_to :game
  belongs_to :character, optional: true
  has_many :recipe_situations, class_name: "Recipe::Situation", dependent: :destroy
  has_many :situations, through: :recipe_situations, source: :situation
  has_many :trainings, dependent: :destroy

  has_many :referred_tos, class_name: "Recipe::Reference", foreign_key: :from_id, dependent: :nullify
  has_one :referred_from, class_name: "Recipe::Reference", foreign_key: :to_id, dependent: :destroy

  scope :in_public, -> { where(public: true) }
  scope :in_private, -> { where(public: false) }

  def copy_to(user)
    ActiveRecord::Base.transaction do
      new_recipe = user.recipes.create!(game:, character:, movements:, comment:)
      Recipe::Reference.create!(to: new_recipe, from: self)
    end
  end
end
