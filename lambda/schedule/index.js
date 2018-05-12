'use strict';

const doc = require('dynamodb-doc');
const dynamo = new doc.DynamoDB();

const { createSchedule } = require('./postSchedule'),
      { updateSchedule } = require('./putSchedule'),
      { getDeviceById } = require('./getSchedule');

const funcs = {
  //TODO: Decide whether to support DELETE
  // DELETE (e, cb) {
    // return dynamo.deleteItem(createBody(e, "StukData"), cb)
  // },
  GET ({queryStringParameters: {DeviceId}}, cb) {
    return dynamo.query(getDeviceById(DeviceId, "Schedule"), cb)
  },
  POST ({body: {Item}}, cb) {
    return dynamo.putItem(createSchedule(Item, "Schedule"), cb)
  },
  PUT ({body: {Item}}, cb) {
    return dynamo.updateItem(updateSchedule(Item, "Schedule"), cb)
  }
};

module.exports = funcs;
