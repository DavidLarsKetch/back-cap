'use strict';

module.exports.getDeviceById = (id, table) => {
  if (!id) return new Error("No device id specified");
  const params = Object.assign({
    "TableName": table,
    "ExpressionAttributeValues": {":id": id},
    "KeyConditionExpression": "DeviceId = :id"
  });
  return params;
};
