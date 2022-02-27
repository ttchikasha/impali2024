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
      div = document.getElementById('new-message');
      div.outerHTML = div.innerHTML;

      messagesEl.scrollTo({ top: messagesEl.innerHTML.length });
    }
  },
});
