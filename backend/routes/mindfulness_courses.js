let express = require('express')
const imageUpload = require('../middleware/multer')

let mRouter = express.Router()


mRouter.post('/api/create-course',imageUpload.single('image'),(req, res, next)=>{
    try{

    }
    catch(e){

    }
})

mRouter.post('/api/get-all-courses',imageUpload.single('image'),(req, res, next)=>{
    try{
        
    }
    catch(e){

    }
})

module.exports = mRouter