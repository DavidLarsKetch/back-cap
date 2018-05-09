'use strict';

const doc = require('dynamodb-doc');

const dynamo = new doc.DynamoDB();

const { createBody } = require('./httpUtils');

const funcs = {
  DELETE (e, cb) {return dynamo.deleteItem(createBody(e, "StukDevice"), cb)},
  GET (e, cb) {return dynamo.scan({TableName: "StukDevice"}, cb)},
  POST (e, cb) {return dynamo.putItem(createBody(e, "StukDevice"), cb)},
  PUT (e, cb) {return dynamo.updateItem(createBody(e, "StukDevice"), cb)},
};

module.exports = funcs;
