import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static targets = ["items", "formWrapper"]

  send(event) {
    event.preventDefault()
    const form = event.target

    fetch(form.action, {
      method: form.method,
      headers: { "Accept": "application/json" },
      body: new FormData(form)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.restaurant_html) {
          this.itemsTarget.insertAdjacentHTML('afterBegin', data.restaurant_html)
          this.formWrapperTarget.classList.toggle('d-none')
        }
        if (data.form_html) form.outerHTML = data.form_html
      })
  }
}
