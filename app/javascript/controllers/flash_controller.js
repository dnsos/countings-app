import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.classList.add("animate-fade-out");
    setTimeout(() => {
      this.element.remove();
    }, 2000);
  }
}
