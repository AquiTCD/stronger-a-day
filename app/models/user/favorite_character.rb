# == Schema Information
#
# Table name: user_favorite_characters
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  character_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_user_favorite_characters_on_character_id              (character_id)
#  index_user_favorite_characters_on_user_id                   (user_id)
#  index_user_favorite_characters_on_user_id_and_character_id  (user_id,character_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#  fk_rails_...  (user_id => users.id)
#
class User::FavoriteCharacter < ApplicationRecord
  belongs_to :user
  belongs_to :character
end
