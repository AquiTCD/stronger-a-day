# == Schema Information
#
# Table name: user_authentications
#
#  id           :bigint           not null, primary key
#  display_name :string
#  email        :string
#  image_url    :string
#  provider     :string           not null
#  uid          :string           not null
#  url          :string
#  username     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_user_authentications_on_provider_and_uid  (provider,uid) UNIQUE
#  index_user_authentications_on_user_id           (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class User::Authentication < ApplicationRecord
  belongs_to :user
  devise :omniauthable, omniauth_providers: %i[twitter2]

  PROVIDERS = %i[twitter2 steam discord].freeze
  enum :provider, PROVIDERS.zip(PROVIDERS.map(&:to_s)).to_h
end
