/* eslint-env jest */

import { enableFetchMocks } from 'jest-fetch-mock'

import React from 'react';
import renderer from 'react-test-renderer';
import Chirp from './Chirp';

// RelativeDateTime changes based on the current time,
// mock it here and we'll test that in its own specs.
jest.mock('./RelativeDateTime', () => 'RelativeDateTime');
jest.mock('global/document', () => ({
  querySelector(selector) {
    if (selector === 'meta[name="csrf-token"]') {
      return { content: 'b5bb9d8014a0f9b1d61e21e796d78dccdf1352f23cd32812f4850b878ae4944c' };
    } else {
      throw new Error('Unexpected queryselector in mocking area');
    }
  }
}));

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

describe('Like button', () => {
  beforeEach(() => {
    enableFetchMocks();
  });

  it('sends a like request to the API', () => {
    fetch.mockResponse((request) => (
      request.url === '/chirps/1/like.json'
        ? (
          Promise.resolve(JSON.stringify({
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
            likes_count: 1,
            liked: true,
            like_url: "/chirps/1/like"
          }))
        )
        : Promise.reject(new Error('Unexpected URL'))
    ));

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

    const treeBefore = component.toJSON();
    expect(treeBefore).toMatchSnapshot();
    
    const likeButton = component.root.find((node) => (
      node.type === 'a' && node.props.href === '/chirps/1/like'
    ));

    // Simulate a click event
    likeButton.props.onClick({ preventDefault: jest.fn() });

    expect(fetch.mock.calls.length).toEqual(1);
    expect(fetch.mock.calls[0][0]).toEqual('/chirps/1/like.json')

    const treeAfter = component.toJSON();
    expect(treeAfter).toMatchSnapshot();

    // We need to give React a moment to re-render the component
    return new Promise((resolve) => {
      setTimeout(() => {
        const treeAfterRefresh = component.toJSON();
        expect(treeAfterRefresh).toMatchSnapshot();
        resolve();
      }, 0);
    });
  });
});
