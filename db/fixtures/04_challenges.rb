CHALLENGES = [
  {
    topic: "飛びを警戒して対空する",
  },
  {
    topic: "被起き攻めや不利状況で暴れずガードする",
  },
  {
    topic: "弾はジャストパリィする",
  },
  {
    topic: "壁付近ではインパクト警戒する",
  },
  {
    topic: "投げとシミーで相手のガードを崩す",
  },
  # {
  #   opponent: Character.find_by(name: 'RYU'),
  #   topic: "弾に釣られて飛ばずにじっくり地上で戦う"
  # },
  # {
  #   opponent: Character.find_by(name: 'LUKE'),
  #   topic: "SA3溜まってない時の強フラにインパクトする"
  # },
  # {
  #   opponent: Character.find_by(name: 'JAIME'),
  #   topic: "前投げ1杯orOD酔疾歩2杯はその場起きからラッシュで咎める"
  # },
  # {
  #   opponent: Character.find_by('CHUN-LI'),
  #   topic: "起き攻め逆択低空百裂を警戒してしゃがみガードで待つ"
  # },
  # {
  #   opponent: Character.find_by('GUILE'),
  #   topic: "ラッシュニーバズガード時、先端以外なら暴れる"
  # },
  # {
  #   opponent: Character.find_by('KIMBERLY'),
  #   topic: "肘落としガードしたら小技で暴れる"
  # },
  # {
  #   opponent: Character.find_by('JURI'),
  #   topic: "近めの中風波はきっちり確反とる"
  # },
  # {
  #   opponent: Character.find_by('KEN'),
  #   topic: "迅雷派生食らったあとは暴れずガードする"
  # },
  # {
  #   opponent: Character.find_by('BLANKA'),
  #   topic:
  # },
  # {
  #   opponent: Character.find_by('DHALSIM'),
  #   topic:
  # },
  # {
  #   opponent: Character.find_by('E.HONDA'),
  #   topic:
  # },
  # {
  #   opponent: Character.find_by('DEE JAY'),
  #   topic:
  # },
  # {
  #   opponent: Character.find_by('MANON'),
  #   topic:
  # },
  # {
  #   opponent: Character.find_by('MARISA'),
  #   topic:
  # },
  # {
  #   opponent: Character.find_by('JP'),
  #   topic:
  # },
  # {
  #   opponent: Character.find_by('ZANGIEF'),
  #   topic:
  # },
  # {
  #   opponent: Character.find_by('LILY'),
  #   topic:
  # },
  # {
  #   opponent: Character.find_by('CAMMY'),
  #   topic:
  # },
  # {
  #   opponent: Character.find_by('RASHID'),
  #   topic:
  # },
  # {
  #   opponent: Character.find_by('A.K.I.'),
  #   topic:
  # },
]
system = User.find_by(name: 'SYSTEM')
game = Game.find_by(title: 'STREET FIGHTER 6')
CHALLENGES.each do |challenge|
  Challenge.seed(:topic,
    challenge.merge(user: system, game: game)
  )
end
