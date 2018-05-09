'use strict';

const doc = require('dynamodb-doc');

const dynamo = new doc.DynamoDB();

const { createBody } = require('./httpUtils');

const funcs = {
  DELETE (e, cb) {return dynamo.deleteItem(createBody(e, "StukUser"), cb)},
  GET (e, cb) {return dynamo.scan({TableName: "StukUser"}, cb)},
  POST (e, cb) {return dynamo.putItem(createBody(e, "StukUser"), cb)},
  PUT (e, cb) {return dynamo.updateItem(createBody(e, "StukUser"), cb)},
};

module.exports = funcs;
