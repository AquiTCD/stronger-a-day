# == Schema Information
#
# Table name: user_tutorials
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  page       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_tutorials_on_user_id           (user_id)
#  index_user_tutorials_on_user_id_and_page  (user_id,page) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_tutorial, class: 'User::Tutorial' do
    
  end
end
