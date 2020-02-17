'use strict';

const doc = require('dynamodb-doc');

const dynamo = new doc.DynamoDB();

const { createBody } = require('../httpUtils');

const funcs = {
  DELETE (e, cb) {return dynamo.deleteItem(createBody(e, "User"), cb)},
  GET (e, cb) {return dynamo.scan({TableName: "User"}, cb)},
  POST (e, cb) {return dynamo.putItem(createBody(e, "User"), cb)},
  PUT (e, cb) {return dynamo.updateItem(createBody(e, "User"), cb)},
};

module.exports = funcs;
