'use strict';

const doc = require('dynamodb-doc');

const dynamo = new doc.DynamoDB();

const { createBody } = require('./httpUtils');

const funcs = {
  DELETE (e, cb) {return dynamo.deleteItem(createBody(e, "StukData"), cb)},
  GET (e, cb) {return dynamo.scan({TableName: "StukData"}, cb)},
  POST (e, cb) {return dynamo.putItem(createBody(e, "StukData"), cb)},
  PUT (e, cb) {return dynamo.updateItem(createBody(e, "StukData"), cb)},
};

module.exports = funcs;
