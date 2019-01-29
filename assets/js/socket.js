// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket,
// and connect at the socket path in "lib/web/endpoint.ex".
//
// Pass the token on params as below. Or remove it
// from the params if you are not using authentication.
import { Socket, Presence } from "phoenix";

let name =
  new URL(window.location.href).searchParams.get("name") || "Anonymous";

let socket = new Socket("/socket", { params: { name } });

// Finally, connect to the socket:
socket.connect();

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("room:lobby", {});
let chatInput = document.querySelector("#chat-input");
let messagesContainer = document.querySelector("#messages");

chatInput.addEventListener("keypress", event => {
  if (event.keyCode === 13) {
    channel.push("new_msg", { body: chatInput.value });
    chatInput.value = "";
  }
});

channel.on("new_msg", payload => {
  let messageItem = document.createElement("li");
  messageItem.innerText = `[${Date()}] ${payload.body}`;
  messagesContainer.appendChild(messageItem);
});

let presence = new Presence(channel);

function renderOnlineUsers(presence) {
  let response = "";

  presence.list((id, { metas: [first, ...rest] }) => {
    let count = rest.length + 1;
    response += `<li>${id} (${count})</li>`;
  });

  document.querySelector("#presence").innerHTML = response;
}

presence.onSync(() => renderOnlineUsers(presence));

channel
  .join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp);
  })
  .receive("error", resp => {
    console.log("Unable to join", resp);
  });

export default socket;
