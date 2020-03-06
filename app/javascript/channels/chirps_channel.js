import consumer from "./consumer"

var channel;

window.addEventListener("turbolinks:load", (event) => {
  if (channel) {
    channel.unsubscribe();
    channel = null;
  }

  var timeline = document.getElementById("chirps");
  if (!timeline) return;

  var user = timeline.getAttribute("data-user");

  channel = consumer.subscriptions.create({ channel: "ChirpsChannel", user: user }, {
    received(data) {
      timeline.insertAdjacentHTML("afterbegin", data.chirp);
    }
  });
});
