//database connection
const DbModel = require("../models/core/dbmodel");
const pool= new DbModel();
pool.connect();
module.exports = pool
