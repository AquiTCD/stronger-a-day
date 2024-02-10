import { Controller } from "@hotwired/stimulus"
import { driver } from "driver.js"
import { post } from '@rails/request.js'

export default class extends Controller {
  static values = {
    updated: Boolean,
  }

  connect() {
    if (this.updatedValue) {
      const d = driver({
        showProgress: true,
        nextBtnText: "次へ →",
        prevBtnText: "← 戻る",
        doneBtnText: "終了",
        steps: [
          {
            popover: {
              title: '結果',
              description: '対戦が終わったら結果を入力します<br /><strong>2先ごとの記録が推奨ですが、ご自身のペース</strong>でかまいません'
            },
          },
          { element: "#general_challenges div:nth-child(1) > div:nth-child(2)",
            popover: {
              title: 'チャレンジ結果入力',
              description: 'チャレンジどおりに<br /><strong>出来た場合:</strong> ✅<br /><strong>出来なかった場合:</strong> ❌<br /><strong>関与なかった場合:</strong> どちらも選択しない<br />'
            },
          },
          { element: '#result_form_comment',
            popover: {
              title: 'コメント入力',
              description: '任意で今の対戦に関するコメントを残すことができます。<br />例えば、対処できなかったり<strong>困らされた相手の行動</strong>や、自分の良かった行動などを書くと良いでしょう。'
            }
          },
          { element: '#match_result',
            popover: {
              title: '対戦結果（勝敗）確定',
              description: '入力し終えたら対戦結果のボタンを押します<br />（回線エラーや、カスタムマッチなどで今回のチャレンジが勝敗結果に影響しないような場合はノーカウントを選択すると勝敗数はカウントされません）'
            }
          }
        ],
        onDestroyStarted: () => {
          if (d.isLastStep()) {
            post("/user/tutorials", {
              body: { page: 'results-new' }
            })
          }
          d.destroy()
        },
      })
      this.driver = d
      this.driver.drive()
    } else {
      this.driver = driver({
        showProgress: true,
        nextBtnText: "次へ →",
        prevBtnText: "← 戻る",
        doneBtnText: "終了",
        steps: [
          { element: "#general_challenges",
            popover: {
              title: '共通チャレンジ',
              description: '選択したチャレンジのうち対戦相手が限定されてないものは常に表示されています。'
            },
          },
          { element: '#opponents',
            popover: {
              title: '対戦相手選択',
              description: '<strong>マッチングしたら対戦相手を選択</strong>してください。<br />対戦相手を限定したチャレンジは選択後に表示されます。'
            }
          },
          { element: '#finish_play',
            popover: {
              title: 'プレイ終了選択',
              description: '対戦後の結果入力のあとはこの画面に戻ってきます。<br />もし今日のプレイを終了する場合はプレイを終了して振り返りに進んでください'
            }
          }
        ],
      })
      this.driver.drive()
    }
  }

  disconnect() {
    if (this.driver) {
      this.driver.destroy()
    }
  }
}
