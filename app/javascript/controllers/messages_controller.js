import { Controller } from 'stimulus';
import consumer from '../channels/consumer';

export default class extends Controller {
  // static targets = [ 'test' ]

  connect() {
    console.log('Hello from messages_controller.js');
    this.element.scrollTo({ top: this.element.innerHTML.length });

    let element = this.element;

    let private_thread_id = parseInt(
      window.location.pathname.split(/private_threads\//)[1],
    );

    if (private_thread_id)
      consumer.subscriptions.create(
        { channel: 'PrivateThreadChannel', private_thread_id },
        {
          connected() {
            // Called when the subscription is ready for use on the server
            console.log('connected');
          },

          disconnected() {
            // Called when the subscription has been terminated by the server
          },

          received(data) {
            console.log('Received data', data);
            let div = document.createElement('div');
            div.setAttribute('id', 'new-message');
            element.appendChild(div);
            div.innerHTML = data.html;

            let name = document.querySelector('#chatee-name').textContent;

            let newMessage = document
              .getElementById('new-message')
              .querySelector('div');

            if (name == data.sender) {
              newMessage.classList.toggle('me');
              newMessage.classList.add('other');
            } else {
              newMessage.classList.toggle('other');
              newMessage.classList.add('me');
            }

            div = document.getElementById('new-message');
            div.outerHTML = div.innerHTML;

            element.scrollTo({ top: element.innerHTML.length });

            // Called when there's incoming data on the websocket for this channel
          },
        },
      );
  }
}
