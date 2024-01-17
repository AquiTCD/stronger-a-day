# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_notes_on_title_id  (title_id)
#  index_notes_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (title_id => titles.id)
#  fk_rails_...  (user_id => users.id)
#
class Note < ApplicationRecord
  belongs_to :user
  belongs_to :title
end
