# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  subject     :string           not null
#  content     :text             not null
#  importance  :string           default("normal"), not null
#  released_at :datetime
#  closed_at   :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Notification < ApplicationRecord
  has_many :user_notifications, class_name: "User::Notification", dependent: :destroy

  IMPORTANCE_VARIATIONS = %i[lowest lower normal higher highest].freeze
  enum :importance, IMPORTANCE_VARIATIONS.zip(IMPORTANCE_VARIATIONS.map(&:to_s)).to_h

  attribute :importance, :string, default: "normal"
  attribute :released_at, :datetime, default: -> { Time.current }
end
