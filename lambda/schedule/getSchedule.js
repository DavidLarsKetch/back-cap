'use strict';

module.exports.getDeviceById = (id, table) => {
  return {
    TableName: table,
    ExpressionAttributeValues: {":id": id},
    KeyConditionExpression: "DeviceId = :id"
  };
};
