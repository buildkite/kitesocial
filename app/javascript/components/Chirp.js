import * as React from 'react';
import PropTypes from 'prop-types';

import UserLink from './UserLink';
import RelativeDateTime from './RelativeDateTime';

const Chirp = ({ chirp }) => {
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
    </div>
  );
};

Chirp.propTypes = {
  chirp: PropTypes.shape({
    content: PropTypes.string.isRequired,
    author: PropTypes.object.isRequired,
    mentions: PropTypes.arrayOf(
      PropTypes.object
    ).isRequired,
    created_at: PropTypes.string.isRequired
  }).isRequired
};

export default Chirp;
