import baseTutorial from "controllers/tutorials/base"

export default function () { return baseTutorial("socials-show", [
  { popover: {
      title: 'みんなのチャレンジ',
      description: 'みんなが公開しているチャレンジ課題をランダムで25件表示しています'
    },
  },
  { element: '#challenges > div > div:nth-child(2)',
    popover: {
      title: 'チャレンジをコピー',
      description: '<svg class="inline-block w-[16px] h-[16px] text-black" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 8v8m0-8a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm0 8a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm12 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm0 0V9a3 3 0 0 0-3-3h-3m1.5-2-2 2 2 2" /></svg>を押すと<strong>自分のチャレンジとして追加</strong>することができます'
    }
  },
])}
