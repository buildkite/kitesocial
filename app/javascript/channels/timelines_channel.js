import consumer from "./consumer"

var channel;

window.addEventListener("turbolinks:load", (event) => {
  if (channel) {
    channel.unsubscribe();
    channel = null;
  }

  var timeline = document.getElementById("timeline");
  if (!timeline) return;

  channel = consumer.subscriptions.create("TimelinesChannel", {
    received(data) {
      timeline.insertAdjacentHTML("afterbegin", data.chirp);
    }
  });
});
