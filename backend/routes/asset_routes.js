let express = require('express')
const auth = require('../tokens/auth')
const path = require('path')
let assetRouter = express.Router()


assetRouter.use('/api/assets/image/user-profs',express.static(path.join(__dirname,'../public/assets/images')))
assetRouter.use('/api/assets/image/mind-course',express.static(path.join(__dirname,'../public/assets/images/mindfulness-courses')))
assetRouter.use('/api/assets/audio/mind-course',express.static(path.join(__dirname,'../public/assets/audio')))


module.exports = assetRouter