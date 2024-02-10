import baseTutorial from "controllers/tutorials/base"

export default function () { return baseTutorial("reviews-index", [
  { popover: {
      title: '振り返り',
      description: '記録した結果をもとに振り返りを行ないます。<br /><strong>何ができて何ができなかったか、</strong><br />どうすればもっと良くなるかを考えるきっかけにしてみましょう。'
    },
  },
  { element: '#challenges div:nth-child(1) > div:nth-child(1)',
    popover: {
      title: '結果カウント',
      description: '<span class="text-green-600 font-bold">できたものは緑</strong></span><br /><span class="text-red-600 font-bold">できなかったものは赤</span><br />で表示されます'
    }
  },
  { element: '#challenges div:nth-child(1) > div:nth-child(4)',
    popover: {
      title: 'チャレンジ達成',
      description: '<strong>完全に身についた</strong>と判断したものは<svg class="w-[16px] h-[16px] inline-block text-black" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 9a3 3 0 0 1 3-3m-2 15h4m0-3c0-4.1 4-4.9 4-9A6 6 0 1 0 6 9c0 4 4 5 4 9h4Z" /></svg>を押すと達成済みになります'
    }
  },
  { element: '.review_comment',
    popover: {
      title: 'コメント',
      description: 'この回のプレイ全体を通してコメントがあれば書き残すことができます'
    }
  },
  { element: '#add-challenge-button',
    popover: {
      title: 'チャレンジ追加',
      description: '左下のアイコンでは、<strong>チャレンジ追加のフォーム</strong>が表示されます。<br />振り返り中に次のチャレンジを思いついたら忘れずに書きましょう',
    }
  },
  { element: '#quick-note-button',
    popover: {
      title: 'クイックメモ',
      description: '右下のアイコンでは、いつでも自由に書ける<strong>クイックメモ</strong>が表示されます。<br />振り返り中に気づいたことがあれば書き残しておきましょう',
    }
  },
  { element: '.review_submit',
    popover: {
      title: 'レビュー完了',
      description: '振り返りが終わったらレビューを完了です。<br />これで<strong>一連のサイクルが終了しました、お疲れ様でした！</strong>'
    }
  }
])}
