'use strict';

const doc = require('dynamodb-doc');

const dynamo = new doc.DynamoDB();

const { createBody } = require('./httpUtils');

const funcs = {
  DELETE (e, cb) {return dynamo.deleteItem(createBody(e, "StukSchedule"), cb)},
  GET (e, cb) {return dynamo.scan({TableName: "StukSchedule"}, cb)},
  POST (e, cb) {return dynamo.putItem(createBody(e, "StukSchedule"), cb)},
  PUT (e, cb) {return dynamo.updateItem(createBody(e, "StukSchedule"), cb)},
};

module.exports = funcs;
