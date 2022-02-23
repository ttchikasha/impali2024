import consumer from './consumer';

consumer.subscriptions.create('ClassroomsChannel', {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('i was connected -->');
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('This is the data ', data);

    let messagesEl = document.getElementById('messages');

    let div = document.createElement('div');
    div.setAttribute('id', 'new-message');
    messagesEl.appendChild(div);
    div.innerHTML = data.html;

    let threadableId = div.querySelector('#threadable_id').textContent;

    if (threadableId == data.classroom_id.toString()) {
      let name = div.querySelector('#current-user').textContent;

      let newMessage = document.getElementById('new-message').querySelector('div');

      if (name == data.sender) {
        newMessage.classList.toggle('other');
        newMessage.classList.add('me');
      } else {
        newMessage.classList.toggle('me');
        newMessage.classList.add('other');
      }

      div = document.getElementById('new-message');
      div.outerHTML = div.innerHTML;

      messagesEl.scrollTo({ top: messagesEl.innerHTML.length });
    }
  },
});
