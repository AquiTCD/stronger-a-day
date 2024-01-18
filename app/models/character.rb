# == Schema Information
#
# Table name: characters
#
#  id           :bigint           not null, primary key
#  title_id     :bigint           not null
#  name         :string           not null
#  display_name :string           not null
#  kana         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_characters_on_title_id  (title_id)
#
# Foreign Keys
#
#  fk_rails_...  (title_id => titles.id)
#
class Character < ApplicationRecord
  belongs_to :title
end
