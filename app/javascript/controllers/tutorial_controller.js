import { Controller } from "@hotwired/stimulus"

// import drive.js objects for tutorials
// NOTE: if the file name includes 'index', will be disappeared from the import path
import gamesShow from "controllers/tutorials/games-show"
import challengesIndex from "controllers/tutorials/challenges-"

const pageTutorials = {
  "games-show": gamesShow,
  "challenges-index": challengesIndex,
}

export default class extends Controller {
  static values = {
    page: String
  }

  connect() {
    console.log(`tutorial: ${this.pageValue}`)
    const pageTutorial = pageTutorials[this.pageValue]
    if (pageTutorial) {
      console.log(pageTutorial.isActive())
      pageTutorial.refresh()
      pageTutorial.drive()
    }
  }

  disconnect() {
    const pageTutorial = pageTutorials[this.pageValue]
    if (pageTutorial) {
      pageTutorial.destroy()
    }
  }
}
