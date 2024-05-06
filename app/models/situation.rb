# == Schema Information
#
# Table name: situations
#
#  id           :bigint           not null, primary key
#  game_id      :bigint           not null
#  name         :string           not null
#  display_name :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_situations_on_game_id           (game_id)
#  index_situations_on_game_id_and_name  (game_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#
class Situation < ApplicationRecord
  belongs_to :game

  validates :name, uniqueness: { scope: :game_id }
end
