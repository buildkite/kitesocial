/* eslint-env jest */

import React from 'react';
import renderer from 'react-test-renderer';
import Chirp from './Chirp';

// RelativeDateTime changes based on the current time,
// mock it here and we'll test that in its own specs.
jest.mock('./RelativeDateTime', () => 'RelativeDateTime');

describe('mention tracking', () => {
  it('links to mentioned users', () => {
    const component = renderer.create(
      <Chirp
        chirp={{
          id: 1,
          author: { id: 1,
            name: "alice",
            url: "/users/1" },
          content: "hey @bob @bob @carol @bob @bob",
          created_at: "2021-04-22T01:08:10Z",
          mentions: [
            { id: 2,
              name: "bob",
              url: "/users/2" },
            { id: 3,
              name: "carol",
              url: "/users/3" }
          ],
          updated_at: "2021-04-22T01:08:10Z",
          likes_count: 0,
          liked: false,
          like_url: "/chirps/1/like"
        }}
      />
    );

    const tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });

  it('avoids things that look like email addresses', () => {
    const component = renderer.create(
      <Chirp
        chirp={{
          id: 1,
          author: { id: 1,
            name: "alice",
            url: "/users/1" },
          content: "I just got a great email from tony@bob.com!",
          created_at: "2021-04-22T01:08:10Z",
          mentions: [],
          updated_at: "2021-04-22T01:08:10Z",
          likes_count: 0,
          liked: false,
          like_url: "/chirps/1/like"
        }}
      />
    );

    const tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });
});
