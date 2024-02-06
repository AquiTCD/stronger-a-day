# == Schema Information
#
# Table name: user_notifications
#
#  id              :bigint           not null, primary key
#  user_id         :bigint           not null
#  notification_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_user_notifications_on_notification_id  (notification_id)
#  index_user_notifications_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (notification_id => notifications.id)
#  fk_rails_...  (user_id => users.id)
#
class User::Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notification
end
