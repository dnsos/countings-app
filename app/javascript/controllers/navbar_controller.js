import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleable", "hamburger", "close"];

  toggle() {
    this.toggleableTarget.classList.toggle("sr-only");
    this.hamburgerTarget.classList.toggle("hidden");
    this.closeTarget.classList.toggle("hidden");
  }
}
