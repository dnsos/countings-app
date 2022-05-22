import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleable", "hamburger", "close"];

  /**
   * Toggles the visibility of the navbar elements
   */
  toggle() {
    // Nav:
    this.toggleableTarget.classList.toggle("sr-only");
    // Hamburger icon:
    this.hamburgerTarget.classList.toggle("hidden");
    // Close icon:
    this.closeTarget.classList.toggle("hidden");
  }
}
