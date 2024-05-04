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

TEKKEN8_SITUATIONS = [
  {
    name: 'wall',
    display_name: '壁',
  },
  {
    name: 'counter',
    display_name: 'カウンター',
  },
  {
    name: 'front only',
    display_name: '正面限定',
  },
  {
    name: 'back only',
    display_name: '背面限定',
  },
  {
    name: 'specific_opponents',
    display_name: '相手キャラ限定',
  },
  {
    name: 'in_heat',
    display_name: 'ヒート中',
  },
  {
    name: 'stage_gimmick',
    display_name: 'ステージギミック',
  },
].freeze

tekken8 = Game.find_by(title: 'TEKKEN 8')
TEKKEN8_SITUATIONS.each do |character|
  Situation.seed(:name,
    character.merge(game: tekken8)
  )
end
