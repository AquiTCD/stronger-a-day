import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submitSelect() {
    this.element.requestSubmit()
  }
}
