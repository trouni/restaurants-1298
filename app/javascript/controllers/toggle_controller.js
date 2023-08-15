import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ['toggleElement']

  connect() {
    // console.log('Connected to toggle controller!')
  }

  fire() {
    this.toggleElementTarget.classList.toggle('d-none')
  }
}
