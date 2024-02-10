import baseTutorial from "controllers/tutorials/base"

export default function () { return baseTutorial("challenges-index", [
  { popover: {
      title: 'チャレンジ管理',
      description: 'ここではチャレンジ課題を追加、編集、削除ができます。<br />チャレンジとは、<strong class="underline">「次、実戦で何をしたら良くなるか」</strong>を明確にしたものです。'
    }
  },
  { element: '#new_challenge #select_character',
    popover: {
      title: 'キャラクター選択',
      description: '操作キャラクター限定のチャレンジを作成する場合は、ここでキャラクターを選択してください。<br />「指定なし」の場合どのキャラクターを選択しても有効になります。'
    }
  },
  { element: '#new_challenge #select_opponent',
    popover: {
      title: '対戦相手指定',
      description: '対戦相手を指定することで、対戦相手限定のチャレンジを作成することができます。<br />こちらも「指定なし」の場合どの対戦相手の場合でも有効になります。'
    }
  },
  { element: '#new_challenge #input_challenge',
    popover: {
      title: 'チャレンジ入力',
      description: 'フリーテキストでチャレンジ内容を入力してください。<br />場面と行動を具体的に書くとより効果的です。'
    }
  },
  { element: '#new_challenge #public',
    popover: {
      title: '公開/非公開',
      description: '非公開にすると他の人から見えなくなります。<br />自分だけのチャレンジを作成する場合は非公開にしてください。'
    }
  },
  { element: '#add-challenge-button',
    popover: {
      title: 'チャレンジ追加モーダル',
      description: 'また常に表示されている左下のアイコンでは、同様にいつでもチャレンジ追加が可能です。<br />思いついたら忘れないうちに追加しましょう。',
    }
  },
  {
    popover: {
      title: 'チャレンジの設定変更',
      description: '追加したチャレンジは以下のアイコンから設定を変更できます<br /><svg class="w-[16px] h-[16px] inline-block text-black" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m14.3 4.8 2.9 2.9M7 7H4a1 1 0 0 0-1 1v10c0 .6.4 1 1 1h11c.6 0 1-.4 1-1v-4.5m2.4-10a2 2 0 0 1 0 3l-6.8 6.8L8 14l.7-3.6 6.9-6.8a2 2 0 0 1 2.8 0Z" /></svg>: 編集<br /><svg class="w-[16px] h-[16px] inline-block text-black" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 7h14m-9 3v8m4-8v8M10 3h4a1 1 0 0 1 1 1v3H9V4a1 1 0 0 1 1-1ZM6 7h12v13a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V7Z" /></svg>: 削除<br /><svg class="w-[16px] h-[16px] text-black inline-block" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m17 21-5-4-5 4V3.9c0-.2 0-.5.2-.6l.6-.3h8.4c.2 0 .4 0 .6.3l.2.6V21Z" /></svg>: ブックマーク（プレイ開始時に自動的に選択）<br />',
    }
  },
])}
