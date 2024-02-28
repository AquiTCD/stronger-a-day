# == Schema Information
#
# Table name: recipe_references
#
#  id         :bigint           not null, primary key
#  from_id    :bigint
#  to_id      :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_recipe_references_on_from_id            (from_id)
#  index_recipe_references_on_from_id_and_to_id  (from_id,to_id) UNIQUE
#  index_recipe_references_on_to_id              (to_id)
#
# Foreign Keys
#
#  fk_rails_...  (from_id => recipes.id)
#  fk_rails_...  (to_id => recipes.id)
#
class Recipe::Reference < ApplicationRecord
  belongs_to :from, class_name: "Recipe", optional: true
  belongs_to :to, class_name: "Recipe"
  counter_culture :from, column_name: "referred_count"

  validates :from_id, uniqueness: { scope: :to_id }
end
