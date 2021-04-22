import * as React from 'react';
import PropTypes from 'prop-types';

import consumer from '../channels/consumer';

import Chirp from './Chirp';

class ChirpsTimeline extends React.PureComponent {
  state = {
    chirps: []
  };

  get chirps() {
    return [
      ...this.state.chirps,
      ...this.props.chirps
    ];
  }

  componentDidMount() {
    if (this.props.subscription) {
      this.channel = consumer.subscriptions.create(
        this.props.subscription,
        { received: this.handleChirpReceived }
      );
    }
  }

  componentWillUnmount() {
    if (this.channel) {
      this.channel.unsubscribe();
      this.channel = null;
    }
  }

  handleChirpReceived = (chirp) => {
    this.setState({ chirps: [...this.state.chirps, chirp] });
  };

  render() {
    return (
      <section>
        {this.chirps.map((chirp) => (
          <Chirp key={chirp.id} chirp={chirp} />
        ))}
      </section>
    );
  }
}

ChirpsTimeline.propTypes = {
  chirps: PropTypes.arrayOf(
    PropTypes.object
  ).isRequired,
  subscription: PropTypes.oneOfType([
    PropTypes.string.isRequired,
    PropTypes.shape({
      channel: PropTypes.string.isRequired,
      user: PropTypes.number
    }).isRequired
  ])
};

export default ChirpsTimeline;
