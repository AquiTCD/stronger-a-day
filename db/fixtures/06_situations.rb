SF6_SITUATIONS = [
  {
    name: 'corner',
    display_name: '画面端',
  },
  {
    name: 'stun',
    display_name: 'スタン',
  },
  {
    name: 'di_corner',
    display_name: '画面端Dインパクト'
  },
  {
    name: 'di_punish_counter',
    display_name: 'Dインパクト パニカン',
  },
  {
    name: 'big_opponent',
    display_name: '相手サイズ:大',
  },
  {
    name: 'small_opponent',
    display_name: '相手サイズ:小',
  },
  {
    name: 'poison',
    display_name: '毒状態',
  },
  {
    name: 'counter',
    display_name: 'カウンター',
  },
  {
    name: 'punish_counter',
    display_name: 'パニッシュカウンター',
  },
  {
    name: 'force_down',
    display_name: 'フォースダウン',
  },
  {
    name: 'anti_air',
    display_name: '対空',
  },
  {
    name: 'anti_air',
    display_name: 'バーンアウト',
  },
]

game = Game.find_by(title: 'STREET FIGHTER 6')
SF6_SITUATIONS.each do |situation|
  Situation.seed(:name,
    situation.merge(game: game)
  )
end
