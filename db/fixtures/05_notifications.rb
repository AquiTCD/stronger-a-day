Notifications = [
  {
    subject: "クローズドベータのお知らせ",
    content:<<~TXT,
        「ヒトツヨ」は現在ベータ版です
        お気づきの点や感想などありましたらぜひ [フィードバック](https://docs.google.com/forms/d/1ab8dY1QGskNXxnQG1Z-Kwsga313ndkinUot3D9uijRg/edit) にご協力ください
      TXT
    importance: :higher,
    released_at: nil,
  },
  {
    subject: "アップデート: v0.2.0",
    content:<<~TXT,
        - マイページ機能を追加
        - 他ユーザーのチャレンジ表示機能を追加
      TXT
    importance: :normal,
    released_at: "2024-02-04 18:45:00".in_time_zone,
  },
  {
    subject: "アップデート: v0.2.1",
    content:<<~TXT,
        - チャレンジ登録モーダルを追加
      TXT
    importance: :normal,
    released_at: "2024-02-04 22:30:00".in_time_zone,
  },
  {
    subject: "アップデート: v0.2.2",
    content:<<~TXT,
        - 振り返り時のレビューコメント機能を追加
      TXT
    importance: :normal,
    released_at: "2024-02-05 10:00:00".in_time_zone,
  },
  {
    subject: "クローズドベータのお知らせ",
    content:<<~TXT,
        「ヒトツヨ」は現在ベータ版です
        お気づきの点や感想などありましたらぜひ [フィードバック](https://docs.google.com/forms/d/1ab8dY1QGskNXxnQG1Z-Kwsga313ndkinUot3D9uijRg/edit) にご協力ください
      TXT
    importance: :higher,
    released_at: nil,
  },
  {
    subject: "プレイ履歴リセットについて",
    content:<<~TXT,
        今後の機能拡充に向けて内部的なデータ構成を変更しました
        そのためやむを得ず、今までのプレイ履歴に関するデータをリセットしました
        大変ご迷惑をおかけしますが、なにとぞご理解いただきますようお願い申し上げます
        また、システムに関する告知やフィードバックのため [Discordサーバー](https://discord.gg/mdrcHnsGz7) を立てました。
        ぜひご参加いただいてご意見いただけましたら幸いです。
      TXT
    importance: :highest,
    released_at: "2024-02-06 10:00:00".in_time_zone,
  },
  {
    subject: "アップデート: v0.3.0",
    content:<<~TXT,
        - お知らせ機能を追加
      TXT
    importance: :normal,
  },
  {
    subject: "アップデート: v0.3.1",
    content:<<~TXT,
        - 使い方説明を表示を一新
      TXT
    importance: :normal,
  },
  {
    subject: "アップデート: v0.4.0",
    content:<<~TXT,
        - トレーニングノート機能を追加
        - コンボ・セットプレイ管理機能を追加
      TXT
    importance: :normal,
  },
  {
    subject: "アップデート: v0.4.1",
    content:<<~TXT,
        - みんなのチャレンジにキャラクター選択を追加
        - みんなのトレーニング、レシピを追加
      TXT
    importance: :normal,
  }
]
Notifications.each do |notification|
  Notification.seed(:subject, notification)
end
