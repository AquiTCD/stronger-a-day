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
game = Game.find_by(title: 'STREET FIGHTER 6')
# FIXME 一時的に追加停止
if system.challenges.size < SF6_CHALLENGES.size
  SF6_CHALLENGES.each do |challenge|
    Challenge.seed(:topic,
      challenge.merge(user: system, game: game)
    )
  end
end
