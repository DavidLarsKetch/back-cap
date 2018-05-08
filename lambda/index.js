'use strict';

const { capitalize, createBody } = require('./httpUtils.js');

const doc = require('dynamodb-doc');

const dynamo = new doc.DynamoDB();

exports.handler = (event, context, callback) => {
    console.log('Received event:', JSON.stringify(event, null, 2));

    const TableName = `Stuk${capitalize(event.resourcePath.slice(1))}`;

    const done = (err, res) => callback(null, {
        statusCode: err ? '400' : '200',
        body: err ? err.message : res,
        headers: {
            'Content-Type': 'application/json',
        },
    });

    switch (event.httpMethod) {
        case 'DELETE':
            dynamo.deleteItem(createBody(event, TableName), done);
            break;
        case 'GET':
            dynamo.scan({ TableName }, done);
            break;
        case 'POST':
            dynamo.putItem(createBody(event, TableName), done);
            break;
        case 'PUT':
            dynamo.updateItem(createBody(event, TableName), done);
            break;
        default:
            done(new Error(`Unsupported method "${event.httpMethod}"`));
    }
};
