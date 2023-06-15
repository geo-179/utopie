import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["code", "render"]
  connect() {
    console.log("hello world")
    const canvas = document.createElement("canvas");
    this.canvasTarget.appendChild(canvas);
    new p5(this.sketch, canvas);
  }

  handleClick(event) {
    this.renderTarget.innerHTML = this.codeTarget.value;
  }
}
