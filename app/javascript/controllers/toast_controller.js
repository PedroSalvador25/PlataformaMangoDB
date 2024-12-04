// app/javascript/controllers/toast_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { hideAfter: Number }

  connect() {
    setTimeout(() => {
      this.element.remove();
    }, this.hideAfterValue || 3000); // Default to 3 seconds
  }
}
