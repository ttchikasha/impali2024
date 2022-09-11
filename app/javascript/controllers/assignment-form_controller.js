import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["document", "questions", "button"];

  connect() {
    console.log("Hello from assignment-form_controller.js");
    let uploadInput = this.documentTarget.querySelector("input[type='file']");
    uploadInput.addEventListener("change", (event) => {
      this.questionsTarget.style.display = "none";
      this.buttonTarget.style.display = "block";
    });
  }
}
