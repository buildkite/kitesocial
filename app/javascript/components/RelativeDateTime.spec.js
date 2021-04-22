/* eslint-env jest */

import React from 'react';
import renderer from 'react-test-renderer';
import RelativeDateTime from './RelativeDateTime';

beforeAll(() => {
  jest.useFakeTimers('modern');
  jest.setSystemTime(new Date('2021-04-22T01:08:10Z').getTime())
});

afterAll(() => {
  jest.useRealTimers();
});

describe('rendering a relative date', () => {
  it('handles values which are less than a second different from the current time', () => {
    const component = renderer.create(
      <RelativeDateTime value="2021-04-22T01:08:10Z" />,
    );
  
    let tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });

  it('handles values measured in seconds', () => {
    const component = renderer.create(
      <RelativeDateTime value="2021-04-22T01:08:01Z" />,
    );
  
    let tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });

  it('handles values measured in minutes', () => {
    const component = renderer.create(
      <RelativeDateTime value="2021-04-22T01:02:01Z" />,
    );
  
    let tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });

  it('handles values measured in hours', () => {
    const component = renderer.create(
      <RelativeDateTime value="2021-04-21T22:02:01Z" />,
    );
  
    let tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });

  it('handles values measured in days', () => {
    const component = renderer.create(
      <RelativeDateTime value="2021-04-18T22:02:01Z" />,
    );
  
    let tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });

  it('handles values measured in weeks', () => {
    const component = renderer.create(
      <RelativeDateTime value="2021-04-01T22:02:01Z" />,
    );
  
    let tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });

  it('handles values measured in months', () => {
    const component = renderer.create(
      <RelativeDateTime value="2021-02-01T22:02:01Z" />,
    );
  
    let tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });

  it('handles values greater than a year old', () => {
    const component = renderer.create(
      <RelativeDateTime value="2020-04-22T00:01:25Z" />,
    );
  
    let tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });

  it('handles negative values measured in seconds', () => {
    const component = renderer.create(
      <RelativeDateTime value="2021-04-22T01:08:45Z" />,
    );
  
    let tree = component.toJSON();
    expect(tree).toMatchSnapshot();
  });
});
