import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['form', 'btn'];

  connect() {
    console.log('Hello from answers_controller.js');
    // console.log(this.testTarget)
    this.formTarget.style.display = 'none';
  }

  toggleForm(event) {
    event.preventDefault();
    this.formTarget.style.display =
      this.formTarget.style.display == 'none' ? 'block' : 'none';
  }
}
