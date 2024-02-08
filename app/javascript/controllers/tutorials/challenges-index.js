import baseTutorial from "controllers/tutorials/base"

export default function () { return baseTutorial("challenges-index", [
  { popover: {
      title: 'チャレンジ管理',
      description: 'ここではチャレンジ課題を追加、編集、削除ができます。<br />チャレンジとは、<strong class="underline">「次、実戦で何をしたら良くなるか」</strong>を明確にしたものです。'
    }
  },
  { element: '#site-title-button',
    popover: {
      title: 'サイトメニュー',
      description: 'ヒトツヨのロゴを押すと、<ul class="font-bold list-disc ml-4"><li>トップページ</li><li>ゲーム選択</li><li>フィードバック</li></ul>などへのリンクが表示されます。'
    }
  },
])}
