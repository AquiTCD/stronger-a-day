# == Schema Information
#
# Table name: user_preferences
#
#  id               :bigint           not null, primary key
#  user_id          :bigint           not null
#  public           :boolean          default(TRUE), not null
#  show_usage       :boolean          default(TRUE), not null
#  show_tips        :boolean          default(TRUE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  default_public   :boolean          default(TRUE), not null
#  styled_movements :boolean          default(TRUE), not null
#
# Indexes
#
#  index_user_preferences_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class User::Preference < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: true
end
