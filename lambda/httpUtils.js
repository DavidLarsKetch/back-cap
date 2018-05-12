'use strict';

module.exports.createBody = ({body}, table, opts) => {
    const obj = body;
    if opts Object.assign(obj, opts);
    obj.TableName = table;
    return obj;
};
