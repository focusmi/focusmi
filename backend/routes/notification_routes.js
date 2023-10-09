let express = require('express')
const pool = require('../database/dbconnection')
const imageUpload = require('../middleware/multer')
const {mindfulness_course} = require('../sequelize/models')
const {notification} = require('../sequelize/models')

let nRouter = express.Router()



module.exports = nRouter
