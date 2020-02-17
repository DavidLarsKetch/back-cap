'use strict';

module.exports.getStatByScheduleId = (id, table) => {
  return {
    TableName: table,
    ExpressionAttributeValues: {":sid": id},
    KeyConditionExpression: "ScheduleId = :sid"
  };
};
