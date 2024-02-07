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
}
