# == Schema Information
#
# Table name: recipe_situations
#
#  id           :bigint           not null, primary key
#  recipe_id    :bigint           not null
#  situation_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_recipe_situations_on_recipe_id                   (recipe_id)
#  index_recipe_situations_on_recipe_id_and_situation_id  (recipe_id,situation_id) UNIQUE
#  index_recipe_situations_on_situation_id                (situation_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#  fk_rails_...  (situation_id => situations.id)
#
class Recipe::Situation < ApplicationRecord
  belongs_to :recipe, class_name: "::Recipe"
  belongs_to :situation, class_name: "::Situation"
end
