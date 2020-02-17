'use strict';

module.exports.getDeviceById = (id, table) => {
  return {
    TableName: table,
    ExpressionAttributeValues: {":id": id},
    KeyConditionExpression: "DeviceId = :id"
  };
};

module.exports.getScheduleByScheduleId = (id, table) => {
  return {
    TableName: table,
    ExpressionAttributeValues: {":id": id},
    FilterExpression: "ScheduleId = :id"
  };
};
