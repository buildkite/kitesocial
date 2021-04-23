/* eslint-env jest */

import React from 'react';
import renderer from 'react-test-renderer';
import ChirpsTimeline from './ChirpsTimeline';
import consumer from '../channels/consumer';

// Mock out the chirps so we just check the basic function of the timeline component
jest.mock('./Chirp', () => 'Chirp');

it('renders chirps which are passed in via props', () => {
  const component = renderer.create(
    <ChirpsTimeline
      chirps={[{
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
      }]}
    />
  );

  const tree = component.toJSON();
  expect(tree).toMatchSnapshot();
});

describe('ActionCable subscriptions', () => {
  it('renders chirps which are passed in via the subscribed channel', () => {
    jest.mock('../channels/consumer');

    const component = renderer.create(
      <ChirpsTimeline
        subscription="MockedChannel"
        chirps={[]}
      />
    );

    const treeBefore = component.toJSON();
    expect(treeBefore).toMatchSnapshot();

    expect(consumer.subscriptions.subscriptions.length).toEqual(1);

    const receivedCallback = consumer.subscriptions.subscriptions[0].received;

    receivedCallback({
      id: 2,
      author: { id: 1,
        name: "alice",
        url: "/users/1" },
      content: "hey again @bob",
      created_at: "2021-04-22T01:08:10Z",
      mentions: [
        { id: 2,
          name: "bob",
          url: "/users/2" }
      ],
      updated_at: "2021-04-22T01:08:10Z",
      likes_count: 0,
      liked: false,
      like_url: "/chirps/1/like"
    });

    const treeAfter = component.toJSON();
    expect(treeAfter).toMatchSnapshot();
  });
});
