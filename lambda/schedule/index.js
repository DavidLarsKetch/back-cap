'use strict';

const doc = require('dynamodb-doc');

const dynamo = new doc.DynamoDB();

const { createBody } = require('../httpUtils');

const { updateSchedule } = require('./postSchedule'),
      { getDeviceById } = require('./getSchedule');

const funcs = {
  DELETE (e, cb) {return dynamo.deleteItem(createBody(e, "Schedule"), cb)},
  GET (e, cb) {return dynamo.query(getDeviceById(e.queryStringParameters.DeviceId, "Schedule"), cb)},
  POST (e, cb) {return dynamo.putItem(updateSchedule(e.body.Item, "Schedule"), cb)},
  PUT (e, cb) {return dynamo.updateItem(updateSchedule(e.body.Item, "Schedule"), cb)},
};

module.exports = funcs;
