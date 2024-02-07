import baseTutorial from "controllers/tutorials/base"

const gamesShowTutorial = baseTutorial("games-show", [
  { popover: {
      title: 'ようこそ ヒトツヨ へ',
      description: 'これからチュートリアルを始めます。<br />まずはじめに、常に表示されているものについて説明です'
    }
  },
  { element: '#site-title-button',
    popover: {
      title: 'サイトメニュー',
      description: 'ヒトツヨのロゴを押すと、<ul class="font-bold list-disc ml-4"><li>トップページ</li><li>ゲーム選択</li><li>フィードバック</li></ul>などへのリンクが表示されます。'
    }
  },
  { element: '#user-menu-button',
    popover: {
      title: 'ユーザーメニュー',
      description: 'ユーザー名を押すと、<ul class="font-bold list-disc ml-4"><li>マイページ</li><li>お知らせ一覧</li><li>ユーザーやアカウント設定</li><li>ログアウト</li></ul>ができます。'
    }
  },
  { element: '#add-challenge-button',
    popover: {
      title: 'チャレンジ追加',
      description: '左下のアイコンでは、<strong>チャレンジ追加のフォーム</strong>が表示されます。<br />思いついたらすぐに追加することができます。',
    }
  },
  { element: '#bottom-home-button',
    popover: {
      title: 'ホーム',
      description: 'こちらはゲームの<strong>メインメニュー</strong>を表示します',
    }
  },
  { element: '#bottom-social-button',
    popover: {
      title: 'みんなのチャレンジ',
      description: 'こちらは<strong>みんなのチャレンジ</strong>を見ることができます。',
    }
  },
  { element: '#quick-note-button',
    popover: {
      title: 'クイックメモ',
      description: '右下のアイコンでは、いつでも自由に書ける<strong>クイックメモ</strong>が表示されます。<br />どの画面を見ていても思いついたことをすぐに書き留めることができます。',
    }
  },
  { element: '#user-menu-button',
    popover: {
      title: 'チュートリアルの再表示',
      description: 'チュートリアルは初回のみ表示されますが、ユーザー設定からいつでも再表示することができます。'
    }
  }
])
export default gamesShowTutorial
