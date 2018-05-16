'use strict'
import moment from 'moment'

export function formatLineGraphData (obj) {
  const timestampsArray = obj.map(i => moment(`${i.Timestamp}-05:00`).format('Do, h:mm:ss a'))
  const readingsArray = obj.map(i => +i.Reading)
  return {
    labels: [...timestampsArray],
    datasets: [
      {
        label: 'Reading',
        borderColor: 'red',
        borderWidth: '2',
        pointRadius: '0',
        fill: 'none',
        data: [...readingsArray, ]
      }
    ]
  }
}
