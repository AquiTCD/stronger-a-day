import { driver } from "driver.js"
import { post } from '@rails/request.js'

export default function (page, steps) {
  console.log(`base: ${page}`)
  const d = driver({
    showProgress: true,
    nextBtnText: "次へ →",
    prevBtnText: "← 戻る",
    doneBtnText: "終了",
    steps: steps,
    onDestroyStarted: () => {
      if (d.isLastStep()) {
        post("/user/tutorials", {
          body: { page: page }
        })
      }
      d.destroy()
    },
  })
  return d
}
// export default baseTutorial
