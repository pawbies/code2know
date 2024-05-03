import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "menu" ]

    initialize() {
        this.state = true;
    }

  toggle() {
      if (this.state)
          this.menuTarget.style.top = "60px";
      else
          this.menuTarget.style.top = "-500px";

      this.state = !this.state;
  }
}
