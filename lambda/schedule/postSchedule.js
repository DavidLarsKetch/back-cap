'use strict';

let UpdateExpression = "SET"
let ExpressionAttributeValues = {};

module.exports.updateSchedule = (obj, table) => {
  const { DeviceId, ScheduleId, ...input } = obj;

  Object.keys(input).forEach((key, idx, arr) => {
    let newKey = `:${key}`;
    UpdateExpression += ` ${key} = ${newKey}`
    if (idx + 1 !== arr.length) UpdateExpression += ",";
    ExpressionAttributeValues[newKey] = obj[key];
  });

  const params = {
    UpdateExpression,
    ExpressionAttributeValues,
    "Key": {
      "DeviceId": DeviceId,
      "ScheduleId": ScheduleId
    },
    "TableName": table
  };

  console.log(params);
  return params;
};
