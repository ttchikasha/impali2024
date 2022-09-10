import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["to", "searchIndividuals", "people"];

  connect() {
    console.log("Hello from notice-form_controller.js");
    console.log(this.values);
    let toSelect = this.toTarget.querySelector("select");
    this.updateUi(toSelect.value);
    toSelect.addEventListener("change", (event) => {
      let to = event.target.value;
      this.updateUi(to);
    });
  }

  updateUi(to) {
    if (to == "Individuals") {
      this.searchIndividualsTarget.style.display = "block";
    } else {
      this.searchIndividualsTarget.style.display = "none";
    }
  }
}
