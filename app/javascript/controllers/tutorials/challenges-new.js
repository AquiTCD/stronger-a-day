import baseTutorial from "controllers/tutorials/base"

export default function () { return baseTutorial("challenges-new", [
  { popover: {
      title: 'チャレンジ選択',
      description: '今回集中するチャレンジを選択します。<br /><strong class="underline">「今回のプレイでこれだけはやるぞ！」</strong>というものを選択してください。'
    },
  },
  { element: '#challenges .grid-cols-subgrid div:nth-child(1)',
    popover: {
      title: '選択',
      description: '前回選択したもの、チャレンジ管理でブックマークしたものは自動的に選択状態になっています'
    }
  },
  { element: '#submit_button',
    popover: {
      title: 'プレイ開始',
      description: '今回挑戦するチャレンジを選択し終えたら、ボタンを押して<strong>マッチングを開始</strong>しましょう。'
    }
  },
])}
