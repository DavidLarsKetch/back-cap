'use strict';

const doc = require('dynamodb-doc');
const dynamo = new doc.DynamoDB();

const { createData } = require('./postData'),
      { getDataByScheduleId } = require('./getData'),
      { updateStat } = require('../stat/putStat'),
      { calcTempStats } = require('../calc/calcStatsOnDataPost');

const funcs = {
  //TODO: Decide whether to support DELETE
  // DELETE (e, cb) {
    // return dynamo.deleteItem(createBody(e, "StukData"), cb)
  // },
  GET ({queryStringParameters: {ScheduleId}}, cb) {
    return dynamo.query(getDataByScheduleId(ScheduleId, "Data"), cb);
  },
  POST ({body: {Item}}, cb) {
    dynamo.query(getDataByScheduleId(Item.ScheduleId, "Data"), (err, res) => {
      if (err) return cb(err, null);

// Does not generate stats on schedules with less than 20 readings
      if (res.Items.length < 20) return dynamo.putItem(createData(Item, "Data"), cb);

      const stats = calcTempStats(res);
      stats.ScheduleId = Item.ScheduleId;
      stats.LastTemp = Item.Reading;
      stats.Stamp = Item.Timestamp;

      dynamo.updateItem(updateStat(stats, "Stat"), (err, res) => {
        if (err) return cb(err, null);

        return dynamo.putItem(createData(Item, "Data"), cb);
      });
    });
  },
  //TODO: Decide whether to support POST
  // PUT (e, cb) {
    // return dynamo.updateItem(createBody(e, "StukData"), cb)
  // }
};

module.exports = funcs;
