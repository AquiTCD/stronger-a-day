import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  add(event) {
    this.inputTarget.value = this.inputTarget.value + event.params.value
  }

  delete() {
    this.inputTarget.value = this.inputTarget.value.slice(0, -1)
  }
}
