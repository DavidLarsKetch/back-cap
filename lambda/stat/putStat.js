'use strict';

module.exports.updateStat = (obj, table) => {
    let ExpressionAttributeValues = {};
    let UpdateExpression = "SET";

    const { ScheduleId, ...input } = obj;

// Creates UpdateExpression str with each key, e.g.:
// UpdateExpression = "SET TempMax=:tempmax, TempMin=:tempmin, TempAvg=:tempavg"
// Creates ExpressionAttributeValues obj with each key, e.g:
// ExpressionAttributeValues = {":tempmin": "65", ":temp": "70"}
    Object.keys(input).forEach((key, idx, arr) => {
        let newKey = ":" + key;
        UpdateExpression += ` ${key}=${newKey},`;
        ExpressionAttributeValues[newKey] = input[key].toString();
    });

    UpdateExpression = UpdateExpression.slice(0, -1);

    return {
        UpdateExpression,
        ExpressionAttributeValues,
        Key: {
            ScheduleId
        },
        TableName: table
    }
};
