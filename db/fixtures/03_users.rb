User.seed(:name,
  {
    name: 'SYSTEM',
    display_name: 'ヒトツヨ'
  }
)
# 最終的にこれを残す
# User::Preference.seed(:user_id,
#   {
#     user: User.find_by(name: 'SYSTEM')
#   }
# )
# DB作りなおし時のみ
User.all.each do |user|
  User::Preference.seed(:user_id,
    {
      user: user
    }
  )
end
