'use strict'

import { Line, mixins } from 'vue-chartjs'
const { reactiveProp } = mixins

export default {
  name: 'line-graph',
  extends: Line,
  mixins: [reactiveProp],
  data () {
    return {
      options: {
        scales: {
          yAxes: [{
            display: true,
            ticks: {
              suggestedMin: 50,
              suggestedMax: 100
            }
          }]
        }
      }
    }
  },
  mounted () {
    // Overwriting base render method with actual data.
    this.renderChart(this.chartData, this.options)
  }
}
