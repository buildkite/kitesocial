import consumer from "./consumer";

let channel;

window.addEventListener("turbolinks:load", () => {
  if (channel) {
    channel.unsubscribe();
    channel = null;
  }

  const timeline = document.getElementById("chirps");
  if (!timeline) {return;}

  const user = timeline.getAttribute("data-user");

  channel = consumer.subscriptions.create({ channel: "ChirpsChannel", user: user }, {
    received(data) {
      timeline.insertAdjacentHTML("afterbegin", data.chirp);
    }
  });
});
