import * as React from 'react';
import PropTypes from 'prop-types';

import UserLink from './UserLink';
import RelativeDateTime from './RelativeDateTime';

export default class Chirp extends React.PureComponent {
  static propTypes = {
    chirp: PropTypes.shape({
      content: PropTypes.string.isRequired,
      author: PropTypes.object.isRequired,
      mentions: PropTypes.arrayOf(
        PropTypes.object
      ).isRequired,
      created_at: PropTypes.string.isRequired,
      liked: PropTypes.bool.isRequired,
      like_url: PropTypes.string.isRequired
    }).isRequired
  };

  state = {
    liking: false,
    likeOverride: null,
    likesCountOverride: null
  };

  get liked() {
    if (this.state.likeOverride !== null) {
      return this.state.likeOverride;
    }

    return this.props.chirp.liked;
  }

  renderLikeButton() {
    const { chirp: { like_url } } = this.props;

    return (
      <a
        href={like_url}
        onClick={this.handleLikeButtonClick}
        disabled={this.state.liking}
      >
        {this.liked ? 'Unlike' : 'Like'}
      </a>
    );
  }

  handleLikeButtonClick = (event) => {
    event.preventDefault();

    if (this.state.liking) {
      return;
    }

    const { chirp: { like_url } } = this.props;

    this.setState({ liking: true }, () => {
      fetch(
        `${like_url}.json`,
        {
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
          },
          method: this.liked ? 'DELETE' : 'POST'
        }
      )
        .then((response) => {
          if (response.ok) {
            return response.json();
          }
          this.setState({ liking: false });

        })
        .then((chirp) => {
          this.setState({
            liking: false,
            likeOverride: chirp.liked,
            likesCountOverride: chirp.likes_count
          });
        });
    });
  };
  
  renderLikesCount() {
    const likes = this.state.likesCountOverride !== null ? this.state.likesCountOverride : this.props.chirp.likes_count;

    return `${likes} like${likes === 1 ? '' : 's'}`;
  }

  render() {
    const { chirp } = this.props;

    const knownMentions = chirp.mentions.reduce((accumulator, value) => {
      accumulator[value.name.toLowerCase()] = value;
      return accumulator;
    }, {});

    // JS can't do negative lookbehinds yet (https://caniuse.com/mdn-javascript_builtins_regexp_lookbehind_assertion),
    // so we need more manual checks in how we process mentions into links
    const output = chirp.content.split(/(@\w+)/).map((segment, index, array) => {
      if ((index === 0 || array[index - 1].match(/[^\w]$/)) && segment.startsWith('@')) {
        const slicedSegment = segment.slice(1).toLowerCase();

        if (Object.prototype.hasOwnProperty.call(knownMentions, slicedSegment)) {
          return <UserLink user={knownMentions[slicedSegment]} key={index} />; // eslint-disable-line react/no-array-index-key
        }
      }

      return segment;
    });

    return (
      <div>
        <p>{ output }</p>
        -- <UserLink user={chirp.author} />
        {', '}
        <RelativeDateTime value={chirp.created_at} />
        {' • '}
        {this.renderLikesCount()}
        {' • '}
        {this.renderLikeButton()}
      </div>
    );
  }
}
