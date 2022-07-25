import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "reloadButton", "theForm" ]

  reload() {
    this.reloadButtonTarget.disabled = true
    this.theFormTarget.submit()
    setTimeout(() => this.reloadButtonTarget.disabled = false, 5000)
  }
}
