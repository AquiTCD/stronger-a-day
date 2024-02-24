import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  connect() {
    this.textarea = this.inputTarget
    this.clientHeight = this.textarea.clientHeight
  }

  add(event) {
    this.inputTarget.value = this.inputTarget.value + event.params.value
    this.input()
  }

  delete() {
    this.inputTarget.value = this.inputTarget.value.slice(0, -1)
    this.input()
  }

  input() {
    this.textarea.style.height = this.clientHeight + 'px';
    let scrollHeight = this.textarea.scrollHeight;
    this.textarea.style.height = scrollHeight + 'px';
  }
}
