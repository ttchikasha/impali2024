import { Controller } from 'stimulus';

export default class extends Controller {
  // static targets = [ 'test' ]

  connect() {
    console.log('Hello from toggle-sidebar_controller.js');
    // console.log(this.testTarget)
  }

  toggle() {
    document.querySelector('body').classList.toggle('toggle-sidebar');
  }
}
