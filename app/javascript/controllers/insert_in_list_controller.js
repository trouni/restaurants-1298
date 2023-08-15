import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static targets = ['list', 'formWrapper']

  connect() {
    console.log(this.listTarget)
  }

  submit(event) {
    // Prevent the default submit
    event.preventDefault()

    const form = event.target
    
    // Using fetch:
    // 1. Create the restaurant
    // 2. Retrieve the new restaurant's card
    // 3. Insert the card in the list using insertAdjacentHTML

    const url = form.action

    fetch(url, {
      method: form.method,
      headers: { "Accept": "application/json" },
      body: new FormData(form)
    })
    .then(response => response.json())
    .then(data => {
      if (data.item_html) {
        this.listTarget.insertAdjacentHTML('afterBegin', data.item_html)
        this.formWrapperTarget.classList.toggle('d-none')
      }

      if (data.form_html) {
        form.outerHTML = data.form_html
      }
    })
  }
}
