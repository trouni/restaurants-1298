import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ['toggleElement']

  connect() {
    console.log('connected')
  }

  toggle(event) {
    // event.target.classList.toggle('d-none')
    this.toggleElementTarget.classList.toggle('d-none')
  }
}
