let express = require('express')
const authuser = require('../models/authuser')
let iTaskRouter = express.Router()

router.get('/api/taskplanner', (req,res) => {
    let user = new authuser();
    
})

router.get('/error',(req,res)=>{
    throw new Error("This is a forced error")
})
module.exports = iTaskRouter