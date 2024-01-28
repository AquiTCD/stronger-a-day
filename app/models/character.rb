# == Schema Information
#
# Table name: characters
#
#  id           :bigint           not null, primary key
#  game_id      :bigint           not null
#  name         :string           not null
#  display_name :string           not null
#  kana         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_characters_on_game_id  (game_id)
#  index_characters_on_name     (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#
class Character < ApplicationRecord
  belongs_to :game
end
