'use strict';

const doc = require('dynamodb-doc');

const dynamo = new doc.DynamoDB();

const { createBody } = require('../httpUtils');

const funcs = {
  // DELETE (e, cb) {return dynamo.deleteItem(createBody(e, "Device"), cb)},
  GET (e, cb) {return dynamo.scan({TableName: "Device"}, cb)},
  POST (e, cb) {return dynamo.putItem(createBody(e, "Device"), cb)},
  PUT (e, cb) {return dynamo.updateItem(createBody(e, "Device"), cb)},
};

module.exports = funcs;
