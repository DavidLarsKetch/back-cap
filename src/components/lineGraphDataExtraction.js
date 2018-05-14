'use strict'

export function formatLineGraphData (obj) {
  const timestampsArray = obj.map(i => i.Timestamp)
  const readingsArray = obj.map(i => +i.Reading)
  return {
    labels: [...timestampsArray],
    datasets: [
      {
        label: 'Readings',
        borderColor: 'red',
        backgroundColor: 'transparent',
        data: [...readingsArray]
      }
    ]
  }
}
