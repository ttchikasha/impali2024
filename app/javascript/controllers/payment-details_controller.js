import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['form', 'owing'];
  connect() {
    console.log('Hello from payment-details_controller.js');
  }

  toggleForm(e) {
    e.preventDefault();
    this.formTarget.classList.toggle('d-none');
    this.owingTarget.classList.toggle('d-none');
  }
}
