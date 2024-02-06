User.seed(:name,
  {
    name: 'SYSTEM',
    display_name: 'ヒトツヨ'
  }
)
User::Preference.seed(:user_id,
  {
    user: User.find_by(name: 'SYSTEM')
  }
)
