import * as React from 'react';

const UserLink = ({ user }) => (
  <a href={user.url}>
    @{user.name}
  </a>
);

export default UserLink;
