//database connection
const dbmodel = require("../models/core/dbmodel");
const pool= new dbmodel();
pool.connect();
module.exports = pool
