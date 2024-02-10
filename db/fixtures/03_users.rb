User.seed(:name,
  {
    name: 'SYSTEM',
    display_name: 'ヒトツヨ'
  }
)
system_user = User.find_by(name: 'SYSTEM')
unless system_user.preference == nil
  User::Preference.seed(:user_id,
    {
      user: system_user
    }
  )
end
