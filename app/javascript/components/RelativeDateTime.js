import * as React from 'react';
import PropTypes from 'prop-types';

import { DateTime } from 'luxon';

const TARGET_UNITS = ['years', 'months', 'weeks', 'days', 'hours', 'minutes', 'seconds'];
const FORMATTER = new Intl.RelativeTimeFormat();

const formatDate = (date) => {
  const elapsed = date.diffNow();

  const unit = TARGET_UNITS.find((unit) => Math.abs(elapsed.as(unit)) >= 1);
  if (!unit) {
    return 'just now';
  }

  const unitValue = Math.round(elapsed.as(unit));

  return FORMATTER.format(unitValue, unit);
};

const RelativeDateTime = ({ value }) => {
  const date = DateTime.fromISO(value);

  return (
    <time
      title={date.toLocaleString(DateTime.DATETIME_SHORT)}
      dateTime={value}
    >
      {formatDate(date)}
    </time>
  );
};

RelativeDateTime.propTypes = {
  value: PropTypes.string.isRequired
};

export default RelativeDateTime;
