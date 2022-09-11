import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["button", "fileInputWrapper"];

  connect() {
    console.log("Hello from upload-answer-form_controller.js");

    let fileInput = this.fileInputWrapperTarget.querySelector("input");

    fileInput.addEventListener("change", (event) => {
      if (event.target.files.length > 0) this.buttonTarget.disabled = false;
      else this.buttonTarget.disabled = false;
    });
  }
}
