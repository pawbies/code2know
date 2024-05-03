import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "message" ]

  close() {
      this.messageTarget.style.right = "-900px";
      this.messageTarget.style.opacity = 0;
  }
}
