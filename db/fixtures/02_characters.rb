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
    display_name: 'マリーザ',
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
  {
    name: 'Ed',
    display_name: 'エド',
    kana: 'エド',
  },
  {
    name: 'GOUKI',
    display_name: '豪鬼',
    kana: 'ゴウキ',
  }
].freeze
sf6 = Game.find_by(title: 'STREET FIGHTER 6')
SF6_CHARACTERS.each do |character|
  Character.seed(:name,
    character.merge(game: sf6)
  )
end

TEKKEN8_CHARACTERS = [
  {
    name: 'Jin Kazama',
    display_name: '仁',
    kana: 'ジン',
  },
  {
    name: 'Kazuya Mishima',
    display_name: '一八',
    kana: 'カズヤ',
  },
  {
    name: 'Jun Kazama',
    display_name: '準',
    kana: 'ジュン',
  },
  {
    name: 'Paul Phenix',
    display_name: 'ポール',
    kana: 'ポール',
  },
  {
    name: 'Marshall Law',
    display_name: 'ロウ',
    kana: 'ロウ',
  },
  {
    name: 'King',
    display_name: 'キング',
    kana: 'キング',
  },
  {
    name: 'Lars Alexandersson',
    display_name: 'ラース',
    kana: 'ラース',
  },
  {
    name: 'Ling Xiaoyu',
    display_name: 'シャオユウ',
    kana: 'シャオユウ',
  },
  {
    name: 'Jack-8',
    display_name: 'ジャック8',
    kana: 'ジャック',
  },
  {
    name: 'Nina Williams',
    display_name: 'ニーナ',
    kana: 'ニーナ',
  },
  {
    name: 'Asuka Kazama',
    display_name: '飛鳥',
    kana: 'アスカ',
  },
  {
    name: 'Leroy Smith',
    display_name: 'リロイ',
    kana: 'リロイ',
  },
  {
    name: 'Lili',
    display_name: 'リリ',
    kana: 'リリ',
  },
  {
    name: 'Hwoarang',
    display_name: 'ファラン',
    kana: 'ファラン',
  },
  {
    name: 'Brayan Fury',
    display_name: 'ブライアン',
    kana: 'ブライアン',
  },
  {
    name: "Claudio Serafino",
    display_name: 'クラウディオ',
    kana: 'クラウディオ',
  },
  {
    name: 'Azucena Milagros Ortiz Castillo',
    display_name: 'アズセナ',
    kana: 'アズセナ'
  },
  {
    name: 'Raven',
    display_name: 'レイヴン',
    kana: 'レイヴン',
  },
  {
    name: 'Yoshimitsu',
    display_name: '吉光',
    kana: 'ヨシミツ',
  },
  {
    name: 'Steve Fox',
    display_name: 'スティーブ',
    kana: 'スティーブ',
  },
  {
    name: 'Sergei Dragunov',
    display_name: 'ドラグノフ',
    kana: 'ドラグノフ'
  },
  {
    name: 'Leo',
    display_name: 'レオ',
    kana: 'レオ'
  },
  {
    name: 'Shaheen',
    display_name: 'シャヒーン',
    kana: 'シャヒーン'
  },
  {
    name: 'Kuma',
    display_name: 'クマ',
    kana: 'クマ',
  },
  {
    name: 'Feng Wei',
    display_name: 'フェン',
    kana: 'フェン',
  },
  {
    name: 'Panda',
    display_name: 'パンダ',
    kana: 'パンダ',
  },
  {
    name: 'Zafina',
    display_name: 'ザフィーナ',
    kana: 'ザフィーナ',
  },
  {
    name: 'Lee Chaolan',
    display_name: 'リー',
    kana: 'リー',
  },
  {
    name: 'Alisa Bosconovitch',
    display_name: 'アリサ',
    kana: 'アリサ',
  },
  {
    name: 'Devil Jin',
    display_name: 'デビル仁',
    kana: 'デビルジン',
  },
  {
    name: 'Victor Chevalier',
    display_name: 'ヴィクター',
    kana: 'ヴィクター',
  },
  {
    name: 'Reina',
    display_name: '麗奈',
    kana: 'レイナ',
  },
  {
    name: 'Eddy Gordo',
    display_name: 'エディ',
    kana: 'エディ',
  },
].freeze

tekken8 = Game.find_by(title: 'TEKKEN 8')
TEKKEN8_CHARACTERS.each do |character|
  Character.seed(:name,
    character.merge(game: tekken8)
  )
end
