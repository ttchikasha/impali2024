import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['role', 'grade', 'room'];

  connect() {
    console.log('Hello from user-form_controller.js');
    let roleSelect = this.roleTarget.querySelector('select');
    this.updateUi(roleSelect.value);
    roleSelect.addEventListener('change', (event) => {
      let role = event.target.value;
      this.updateUi(role);
    });
  }

  updateUi(role) {
    if (role == 'Admin' || role == 'Teacher') {
      this.gradeTarget.parentElement.style.display = 'none';
      this.roomTarget.parentElement.style.display = 'none';
    } else {
      this.gradeTarget.parentElement.style.display = 'block';
      this.roomTarget.parentElement.style.display = 'block';
    }
  }
}
