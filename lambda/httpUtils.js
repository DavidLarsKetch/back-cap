'use strict';

module.exports.capitalize = str => str.slice(0,1).toUpperCase() + str.slice(1);

module.exports.createBody = ({body}, table) => {
    const obj = body;
    obj.TableName = table;
    return obj;
};
