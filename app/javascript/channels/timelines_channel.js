import consumer from "./consumer";

let channel;

window.addEventListener("turbolinks:load", () => {
  if (channel) {
    channel.unsubscribe();
    channel = null;
  }

  const timeline = document.getElementById("timeline");
  if (!timeline) {return;}

  channel = consumer.subscriptions.create("TimelinesChannel", {
    received(data) {
      timeline.insertAdjacentHTML("afterbegin", data.chirp);
    }
  });
});
