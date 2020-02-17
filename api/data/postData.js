'use strict';

module.exports.createData = (obj, table) => {
  return {
    Item: obj,
    TableName: table
  };
};
