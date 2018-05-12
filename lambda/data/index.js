'use strict';

const doc = require('dynamodb-doc');
const dynamo = new doc.DynamoDB();

const { createData } = require('./postData'),
      { getDataByScheduleId } = require('./getData');

const funcs = {
  //TODO: Decide whether to support DELETE
  // DELETE (e, cb) {
    // return dynamo.deleteItem(createBody(e, "StukData"), cb)
  // },
  GET ({queryStringParameters: {ScheduleId}}, cb) {
    return dynamo.query(getDataByScheduleId(ScheduleId, "Data"), cb)
  },
  POST ({body: {Item}}, cb) {
    return dynamo.putItem(createData(Item, "Data"), cb)
  },
  //TODO: Decide whether to support POST
  // PUT (e, cb) {
    // return dynamo.updateItem(createBody(e, "StukData"), cb)
  // }
};

module.exports = funcs;
