'use strict';
//TODO: potentially bring in lodash or rambda
let avg = 0;

module.exports.calcTempStats = ({Items}) => {
  Items = Items
    .map(i => {
      const Reading = +i.Reading;
      avg += Reading;
      return {Reading, Timestamp: i.Timestamp};
    })
    .sort((a, b) => a.Reading - b.Reading);
  avg = Math.round( ( avg / Items.length ), 2 );
  const min = Items.shift();
  const max = Items.pop();

  return {
    TempMax: max.Reading,
    TimestampMax: max.Timestamp,
    TempAvg: avg,
    TempMin: min.Reading,
    TimestampMin: min.Timestamp
  };
};
