'use strict';


module.exports.updateSchedule = (obj, table) => {
  let UpdateExpression = "SET";
  let ExpressionAttributeValues = {};

  const { ScheduleId, DeviceId, ...input } = obj;

// Creates UpdateExpression str with each key, e.g.:
// UpdateExpression = "SET TempMax=:tempmax, TempMin=:tempmin, TempAvg=:tempavg"
// Creates ExpressionAttributeValues obj with each key, e.g:
// ExpressionAttributeValues = {":tempmin": "65", ":temp": "70"}
  Object.keys(input).forEach((key, idx, arr) => {
    let newKey = ":" + key;
    UpdateExpression += ` ${key}=${newKey},`;
    ExpressionAttributeValues[newKey] = input[key].toString();
  });

//Removes trailing comma
  UpdateExpression = UpdateExpression.slice(0, -1);

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
