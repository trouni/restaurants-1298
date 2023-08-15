import { Controller } from "@hotwired/stimulus"
import 'flatpickr'

// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    // In Stimulus, `this.element` is the top parent HTML element on which you added the `data-controller` attribute
    flatpickr(this.element)
  }
}
