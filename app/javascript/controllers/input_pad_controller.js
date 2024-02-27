import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  connect() {
    this.textarea = this.inputTarget
    this.clientHeight = this.textarea.clientHeight
  }

  add(event) {
    const inputValue = isNaN(event.params.value) ? event.params.value :  String(event.params.value)
    const caretPosition = this.textarea.selectionStart
    const beforeCaret = this.textarea.value.substr(0, caretPosition)
    const afterCaret = this.textarea.value.substr(caretPosition)

    this.textarea.value = `${beforeCaret}${inputValue}${afterCaret}`
    const newCaretPosition = caretPosition + inputValue.length
    this.input()

    this.textarea.setSelectionRange(newCaretPosition, newCaretPosition);
    this.textarea.focus()
  }

  delete() {
    const caretPosition = this.textarea.selectionStart
    if (caretPosition === 0) {
      this.textarea.focus()
      return
    }

    const beforeCaret = this.textarea.value.substr(0, caretPosition)
    const afterCaret = this.textarea.value.substr(caretPosition)

    this.textarea.value = `${beforeCaret.slice(0, -1)}${afterCaret}`
    const newCaretPosition = caretPosition - 1
    this.input()

    this.textarea.setSelectionRange(newCaretPosition, newCaretPosition);
    this.textarea.focus()
  }

  input() {
    this.textarea.style.height = this.clientHeight + 'px';
    let scrollHeight = this.textarea.scrollHeight;
    this.textarea.style.height = scrollHeight + 'px';
  }
}
