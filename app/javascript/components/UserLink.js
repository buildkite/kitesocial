import * as React from 'react';
import PropTypes from 'prop-types';

const UserLink = ({ user }) => (
  <a href={user.url}>
    @{user.name}
  </a>
);

UserLink.propTypes = {
  user: PropTypes.shape({
    name: PropTypes.string.isRequired,
    url: PropTypes.string.isRequired
  }).isRequired
};

export default UserLink;
