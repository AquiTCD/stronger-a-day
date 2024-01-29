# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  game_id    :bigint           not null
#  content    :text             default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_notes_on_game_id  (game_id)
#  index_notes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_id => games.id)
#  fk_rails_...  (user_id => users.id)
#
class Note < ApplicationRecord
  belongs_to :user
  belongs_to :game
end
