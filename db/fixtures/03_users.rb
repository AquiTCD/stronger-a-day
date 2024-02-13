User.seed(:name,
  {
    name: 'SYSTEM',
    display_name: 'ヒトツヨ'
  }
)
# system_user = User.find_by(name: 'SYSTEM')
# if system_user.preference.blank?
#   User::Preference.seed(:user_id,
#     {
#       user: system_user
#     }
#   )
# end
User.all.order(:id).each do |user|
  user.create_preference
end
