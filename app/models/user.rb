# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  display_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_users_on_display_name  (display_name) UNIQUE
#  index_users_on_name          (name) UNIQUE
#
class User < ApplicationRecord
  devise :authenticatable
  has_one :registration, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :notes, dependent: :destroy

  def registered?
    registration.present?
  end
end
