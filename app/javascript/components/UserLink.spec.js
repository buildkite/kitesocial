/* eslint-env jest */

import React from 'react';
import renderer from 'react-test-renderer';
import UserLink from './UserLink';

it('renders as a link based on the user data', () => {
  const component = renderer.create(
    <UserLink
      user={{
        id: 1,
        name: "alice",
        url: "/users/1"
      }}
    />,
  );

  let tree = component.toJSON();
  expect(tree).toMatchSnapshot();
});
