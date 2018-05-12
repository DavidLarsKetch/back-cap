'use strict';

let UpdateExpression = "SET"
let ExpressionAttributeValues = {};

module.exports.updateSchedule = (obj, table) => {
  const { ScheduleId, DeviceId, ...input } = obj;

  Object.keys(input).forEach((key, idx, arr) => {
    let newKey = `:${key}`;
    UpdateExpression += ` ${key} = ${newKey}`;
    if (idx + 1 !== arr.length) UpdateExpression += ",";
    ExpressionAttributeValues[newKey] = input[key];
  });

  return {
    UpdateExpression,
    ExpressionAttributeValues,
    Key: {
      DeviceId: DeviceId,
      ScheduleId: ScheduleId
    },
    TableName: table
  };
};
