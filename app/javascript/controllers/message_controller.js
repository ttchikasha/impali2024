import { Controller } from 'stimulus';

export default class extends Controller {
  static values = { senderId: Number };
  connect() {
    console.log('SenderId ->', this.senderIdValue);

    let currentUserId = document.querySelector('#current-user-id').textContent;

    if (this.senderIdValue == currentUserId) {
      this.element.classList.add('me');
      this.element.classList.remove('other');
    } else {
      this.element.classList.add('other');
      this.element.classList.remove('me');
    }
  }
}
