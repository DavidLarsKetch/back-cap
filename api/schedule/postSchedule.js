'use strict';

module.exports.createSchedule = (obj, table) => {
  return {
    Item: obj,
    TableName: table
  };
};
