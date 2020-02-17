'use strict';

const doc = require('dynamodb-doc');
const dynamo = new doc.DynamoDB();
const { getStatByScheduleId } = require('./getStat');

const funcs = {
    GET: function({queryStringParameters: {ScheduleId}}, cb) {
        return dynamo.query(getStatByScheduleId(ScheduleId, "Stat"), cb);
    }
};

module.exports = funcs;
