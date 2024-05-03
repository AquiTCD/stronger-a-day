SF6_CHALLENGES = [
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
  }
]
system = User.find_by(name: 'SYSTEM')
sf6 = Game.find_by(title: 'STREET FIGHTER 6')
# FIXME 一時的に追加停止
if system.challenges.where(game: sf6).size < SF6_CHALLENGES.size
  SF6_CHALLENGES.each do |challenge|
    Challenge.seed(:topic,
      challenge.merge(user: system, game: sf6)
    )
  end
end

TEKKEN8_CHALLENGES = [
  {
    topic: "スキの大きい技をガードしたら最速攻撃で確反とる",
  },
  {
    topic: "ガードが固い相手には投げを混ぜる",
  },
  {
    topic: "ヒート状態になったらヒートダッシュから択をかける",
  },
  {
    topic: "起き上がりの動作（受け身、蹴り、寝っぱ、その場起きなど）を散らす",
  },
].freeze
tekken8 = Game.find_by(title: 'TEKKEN 8')
if system.challenges.where(game: tekken8).size < TEKKEN8_CHALLENGES.size
  TEKKEN8_CHALLENGES.each do |challenge|
    Challenge.seed(:topic,
      challenge.merge(user: system, game: tekken8)
    )
  end
end
