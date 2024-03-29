# == Schema Information
#
# Table name: user_authentications
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  provider     :string           not null
#  uid          :string           not null
#  username     :string
#  display_name :string
#  url          :string
#  image_url    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_user_authentications_on_provider_and_uid      (provider,uid) UNIQUE
#  index_user_authentications_on_provider_and_user_id  (provider,user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class User::Authentication < ApplicationRecord
  belongs_to :user
  devise :omniauthable, omniauth_providers: %i[twitter2 discord steam]

  PROVIDERS = %i[twitter2 discord steam].freeze
  enum :provider, PROVIDERS.zip(PROVIDERS.map(&:to_s)).to_h

  # NOTE: devise認証にemail attributeが求められるので強制的にnilで扱う
  attribute :email, :string, default: nil
end
