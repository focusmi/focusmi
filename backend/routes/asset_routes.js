let express = require('express')
const auth = require('../tokens/auth')
const path = require('path')
let assetRouter = express.Router()


assetRouter.use('/api/assets/image/user-profs',express.static(path.join(__dirname,'../public/assets/images/user-profiles')))
assetRouter.use('/api/assets/image/mind-course',express.static(path.join(__dirname,'../public/assets/images/mindfulness-courses')))


module.exports = assetRouter