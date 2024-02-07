import { driver } from "driver.js"
import { post } from '@rails/request.js'

const Tutorial = driver({
  showProgress: true,
  nextBtnText: "次へ →",
  prevBtnText: "← 戻る",
  doneBtnText: "終了",
  steps: [
    { popover: {
        title: 'ようこそ ヒトツヨ へ',
        description: 'これからチュートリアルを始めます。\nまずはじめに、常に表示されているものについて説明です'
      }
    },
    { element: '#site-title-button',
      popover: {
        title: 'サイトメニュー',
        description: 'ヒトツヨのロゴを押すと、トップページやゲーム選択へのリンクが表示されます。'
      }
    },
    { element: '#user-menu-button',
      popover: {
        title: 'ユーザーメニュー',
        description: 'ユーザー名を押すと、ユーザー情報の変更や設定変更、ログアウトができます。'
      }
    },
    { element: '#quick-note-button',
      popover: {
        title: 'クイックメモ',
        description: '右下のアイコンでは、いつでも自由に書けるクイックメモが表示されます。',
      }
    },
    { element: '#add-challenge-button',
      popover: {
        title: 'チャレンジ追加',
        description: '左下のアイコンでは、チャレンジ追加のフォームが表示されます。\n思いついたらすぐに追加することができます。',
      }
    },
  ],
  onDestroyStarted: () => {
    if (Tutorial.isLastStep()) {
      const response = post("/user/tutorials", {
        body: { page: 'games-show' }
      })
    }
    Tutorial.destroy()
  },
})
export default Tutorial
