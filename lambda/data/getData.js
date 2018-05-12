'use strict';

module.exports.getDataByScheduleId = (id, table) => {
  return {
    TableName: table,
    ExpressionAttributeValues: {":sid": id},
    KeyConditionExpression: "ScheduleId = :sid"
  };
};
