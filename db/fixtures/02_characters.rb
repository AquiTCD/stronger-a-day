SF6_CHARACTERS = [
  {
    name: 'RYU',
    display_name: 'リュウ',
    kana: 'リュウ',
  },
  {
    name: 'LUKE',
    display_name: 'ルーク',
    kana: 'ルーク',
  },
  {
    name: 'JAIME',
    display_name: 'ジェイミー',
    kana: 'ジェイミー',
  },
  {
    name: 'CHUN-LI',
    display_name: '春麗',
    kana: 'チュンリー',
  },
  {
    name: 'GUILE',
    display_name: 'ガイル',
    kana: 'ガイル',
  },
  {
    name: 'KIMBERLY',
    display_name: 'キンバリー',
    kana: 'キンバリー',
  },
  {
    name: 'JURI',
    display_name: 'ジュリ',
    kana: 'ジュリ',
  },
  {
    name: 'KEN',
    display_name: 'ケン',
    kana: 'ケン',
  },
  {
    name: 'BLANKA',
    display_name: 'ブランカ',
    kana: 'ブランカ',
  },
  {
    name: 'DHALSIM',
    display_name: 'ダルシム',
    kana: 'ダルシム',
  },
  {
    name: 'E.HONDA',
    display_name: 'E.本田',
    kana: 'ホンダ',
  },
  {
    name: 'DEE JAY',
    display_name: 'ディージェイ',
    kana: 'ディージェイ',
  },
  {
    name: 'MANON',
    display_name: 'マノン',
    kana: 'マノン',
  },
  {
    name: 'MARISA',
    display_name: 'マリ-ザ',
    kana: 'マリーザ',
  },
  {
    name: 'JP',
    display_name: 'JP',
    kana: 'ジェイピー',
  },
  {
    name: 'ZANGIEF',
    display_name: 'ザンギエフ',
    kana: 'ザンギエフ',
  },
  {
    name: 'LILY',
    display_name: 'リリー',
    kana: 'リリー',
  },
  {
    name: 'CAMMY',
    display_name: 'キャミィ',
    kana: 'キャミィ',
  },
  {
    name: 'RASHID',
    display_name: 'ラシード',
    kana: 'ラシード',
  },
  {
    name: 'A.K.I.',
    display_name: 'A.K.I.',
    kana: 'アキ',
  },
]
sf6 = Game.find_by(title: 'STREET FIGHTER 6')
SF6_CHARACTERS.each do |character|
  Character.seed(:name,
    character.merge(title: sf6)
  )
end
