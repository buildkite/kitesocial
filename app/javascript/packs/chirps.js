import * as React from 'react';
import ReactDOM from 'react-dom';
import ChirpsTimeline from '../components/ChirpsTimeline';

const timeline = document.getElementById("chirps");
const user = timeline.getAttribute("data-user");

ReactDOM.render(
  <ChirpsTimeline
    subscription={{ channel: "ChirpsChannel", user: user }}
    chirps={JSON.parse(document.getElementById("data").innerHTML)}
  />,
  timeline
);
