Notifications = [
  {
    subject: "クローズドベータのお知らせ",
    content:<<~TXT,
        「ヒトツヨ」は現在ベータ版です
        お気づきの点や感想などありましたらぜひ [フィードバック](https://docs.google.com/forms/d/1ab8dY1QGskNXxnQG1Z-Kwsga313ndkinUot3D9uijRg/edit) にご協力ください
      TXT
    importance: :higher,
    released_at: "2024-02-03 10:00:00".in_time_zone,
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
  },
  {
    subject: "アップデート: v0.5.0",
    content:<<~TXT,
        - Discord ログイン機能を追加
        - Steam ログイン機能を追加
      TXT
    importance: :normal,
  },
  {
    subject: "プライバシーポリシー、利用規約の改訂 2024年2月18日",
    content:<<~TXT,
        プライバシーポリシー、利用規約の改訂を行いました。
        ご確認の上、ご同意いただけましたら引き続きご利用ください。
      TXT
    importance: :highest,
  },
  {
    subject: "オープンベータ公開のお知らせ",
    content:<<~TXT,
        このたび「ヒトツヨ」はオープンベータ版として公開いたしました。
        お気づきの点や感想などありましたら、ぜひフィードバックにご協力ください。

        フィードバックは、[専用フォーム](https://docs.google.com/forms/d/1ab8dY1QGskNXxnQG1Z-Kwsga313ndkinUot3D9uijRg/edit) 、または [サポート用 Discord](https://discord.gg/mdrcHnsGz7) にてお寄せいただけます。
      TXT
    importance: :higher,
    released_at: nil,
  },
  {
    subject: "不具合について 2024年2月18日",
    content:<<~TXT,
        - DiscordとSteamサインインができない（現在一時的に利用不可にしました）
        - 一度使ったチャレンジを削除できない

        ご不便をおかけして申し訳ございません、修正に向けて対応中です。
        また、サポートやフィードバック用の [Discordサーバー](https://discord.gg/mdrcHnsGz7) があります。是非ご参加いただいてご意見いただけましたら幸いです。
      TXT
    importance: :higher,
    released_at: "2024-02-18 18:00:00".in_time_zone,
  },
  {
    subject: "アップデート: v0.5.1",
    content:<<~TXT,
        - Discord、Steamサインインができない問題が解消できたので再度有効化
      TXT
    importance: :normal,
  },
  {
    subject: "アップデート: v0.5.2",
    content:<<~TXT,
        - レシピコメントが必須になっていたのを任意に修正
        - レシピ状況をいくつか追加
      TXT
    importance: :normal,
  },
  {
    subject: "アップデート: v0.5.3",
    content:<<~TXT,
        - 軽微な表示の改善
        - チャレンジ、トレーニング、レシピの公開設定の初期値を設定可能に
      TXT
    importance: :normal,
  },
  {
    subject: "アップデート: v0.5.4",
    content:<<~TXT,
        - 連携アカウントの画像がない場合エラーになる問題の修正
        - みんなのチャレンジで稀に404エラーが発生する問題の修正
        - その他軽微な修正
      TXT
    importance: :normal,
  },
  {
    subject: "アップデート: v0.6.0",
    content:<<~TXT,
        - チャレンジやレシピに簡易入力パッド機能を追加
        - チャレンジやレシピに装飾表示の追加
      TXT
    importance: :normal,
  },
  {
    subject: "アップデート: v0.6.1",
    content:<<~TXT,
        - ストリートファイター6にエドを追加
        - よくある質問ページを追加
      TXT
    importance: :normal,
  },
  {
    subject: "アップデート: v0.6.2",
    content:<<~TXT,
        - 簡易入力パッドの改善（キャレット位置に文字挿入）
        - コマンド装飾の判定改善
      TXT
    importance: :normal,
  },
  {
    subject: "アップデート: v0.7.0",
    content:<<~TXT,
        - みんなのレシピにコピー機能を追加
        - コマンド装飾の判定改善
        - 表示の改善
      TXT
    importance: :normal,
  },
]
Notifications.each do |notification|
  Notification.seed(:subject, notification)
end
