import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['avatar', 'input', 'originalAvatar'];

  connect() {
    console.log('Hello from avatar-upload_controller.js');
    console.log(this.avatarTarget);
    this.inputTarget.addEventListener('change', (event) => {
      let image = event.target.files[0];
      this.avatarTarget.setAttribute('src', URL.createObjectURL(image));
    });
  }

  pick() {
    this.inputTarget.click();
  }

  reset() {
    this.avatarTarget.setAttribute(
      'src',
      this.originalAvatarTarget.getAttribute('src'),
    );
  }
}
