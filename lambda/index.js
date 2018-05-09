'use strict';

const funcs = {
  data: require('./data'),
  device: require('./device'),
  schedule: require('./schedule'),
  user: require('./user')
};

const doc = require('dynamodb-doc');

const dynamo = new doc.DynamoDB();

exports.handler = (event, context, callback) => {
    const done = (err, res) => callback(null, {
      statusCode: err ? '400' : '200',
      body: err ? err.message : res,
      headers: {
        'Content-Type': 'application/json',
      },
    });

  const method = event.httpMethod;

  // Removing leading '/', uses the resource name to
  // call the appropriate module
  const resource = event.resourcePath.slice(1);

  funcs[resource][method](event, done);
};
