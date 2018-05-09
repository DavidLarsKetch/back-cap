'use strict';

module.exports.createBody = ({body}, table, opts) => {
    const obj = body;
    obj.TableName = table;
    return obj;
};
