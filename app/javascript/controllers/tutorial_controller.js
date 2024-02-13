import { Controller } from "@hotwired/stimulus"

const pageTutorials = {
  "games-show": "controllers/tutorials/games-show",
  "challenges-index": "controllers/tutorials/challenges-",
  "challenges-new": "controllers/tutorials/challenges-new",
  "reviews-index": "controllers/tutorials/reviews-",
  "socials-show": "controllers/tutorials/socials-show",
  "trainings-index": "controllers/tutorials/trainings-",
  "recipes-index": "controllers/tutorials/recipes-",
}

export default class extends Controller {
  static values = {
    page: String,
  }

  // TODO: 二回呼ばれるのをなんとかしたくはある
  connect() {
    const page = pageTutorials[this.pageValue]
    if (page && this.deliver == undefined) {
      import(pageTutorials[this.pageValue])
      .then((pageTutorial) => {
        this.driver = pageTutorial.default()
        this.driver.drive()
      })
    }
  }

  disconnect() {
    if (this.driver) {
      this.driver.destroy()
    }
  }
}
