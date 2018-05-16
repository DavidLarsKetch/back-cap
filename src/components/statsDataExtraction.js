'use strict'

import moment from 'moment'

export function extractStatsData (obj) {
  console.log(obj);
  return {
    avg: obj.TempAvg,
    temp: obj.LastTemp,
    timeLast: moment(`${obj.Stamp}-05:00`).format('MMM Do, h:mm:ss a'),
    tempMax: obj.TempMax,
    timeMax: moment(`${obj.TimestampMax}-05:00`).format('MMM Do, h:mm:ss a'),
    tempMin: obj.TempMin,
    timeMin: moment(`${obj.TimestampMin}-05:00`).format('MMM Do, h:mm:ss a')
  }
}
