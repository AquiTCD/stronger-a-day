import baseTutorial from "controllers/tutorials/base"

export default function () { return baseTutorial("trainings-index", [
  { popover: {
      title: 'トレーニングノート',
      description: 'ここではトレーニングメニューを追加、編集、削除ができます。<br />特定のコンボやセットプレイや決まったメニューを管理できます'
    }
  },
  { element: '#select_recipe',
    popover: {
      title: '関連レシピ',
      description: 'レシピが登録されている場合、トレーニングに関連づけることができます'
    }
  },
  { element: '#input_training',
    popover: {
      title: 'トレーニング入力',
      description: 'トレーニング内容を入力します。<br />関連レシピがある場合「{関連レシピ名} {トレーニングメニュー}」と表示されます。'
    }
  },
  {
    popover: {
      title: 'トレーニング記録',
      description: '登録したトレーニングは、<svg class="inline-block w-[16px] h-[16px] text-black" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.5 11.5 11 14l4-4m6 2a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" /></svg>かトレーニングを押すと、行った記録をコメントをつけることができます。'
    }
  }
])}
