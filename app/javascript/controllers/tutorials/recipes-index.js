import baseTutorial from "controllers/tutorials/base"

export default function () { return baseTutorial("recipes-index", [
  { popover: {
      title: 'レシピ管理',
      description: 'ここではコンボやセットプレイを追加、編集、削除ができます。'
    }
  },
  { element: '#select_situations',
    popover: {
      title: '状況選択',
      description: '状況を限定したコンボやセットプレイのために、状況を設定できます。<br />複数同時に設定可能です'
    }
  },
  { element: '#input_movements',
    popover: {
      title: '動作入力',
      description: '実際のコンボの入力動作を入力します。<br />例）「強P > 2中K > 236P」'
    }
  },
  { element: '#input_comment',
    popover: {
      title: 'コメント入力',
      description: 'それ以外に何かメモがあれば入力できます<br />例えば、その後の状況やゲージ消費量などを追記すると良いでしょう'
    }
  }
])}
