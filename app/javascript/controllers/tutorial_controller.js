import { Controller } from "@hotwired/stimulus"

// import drive.js objects for tutorials
import gamesShow from "controllers/tutorials/games-show"
const pageTutorials = {
  "games-show": gamesShow
}

export default class extends Controller {
  static targets = ["page"]

  connect() {
    const page = this.pageTarget.dataset.page
    const tutorial = pageTutorials[page]
    if (tutorial) {
      tutorial.drive()
    }
  }

  disconnect() {
    const page = this.pageTarget.dataset.page
    const tutorial = pageTutorials[page]
    if (tutorial) {
      tutorial.destroy()
    }
  }
  // 最後を押した時の処理
  onClickLast() {
    const response = await fetch(url, {
      document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      //csrf-token設定。ヘッダーから取り出したトークンをセット
      axios.defaults.headers.common['X-CSRF-Token'] = token
      //Ajaxで送信するようにjsモードで送る。`local:false`に当たる設定。
      axios.defaults.headers.common['Accept'] = 'application/js'
      return axios
    }


    method: "POST", // *GET, POST, PUT, DELETE, etc.
    mode: "cors", // no-cors, *cors, same-origin
    cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
    credentials: "same-origin", // include, *same-origin, omit
    headers: {
      "Content-Type": "application/json",
      // 'Content-Type': 'application/x-www-form-urlencoded',
    },
  }
}
