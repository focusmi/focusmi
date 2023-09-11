let express = require('express')
let therapistRouter = express.Router()

router.get('/person/:name', (req,res) => {
    res.send(`You have been served ${req.params.name}`)
})

router.get('/error',(req,res)=>{
    throw new Error("This is a forced error")
})
module.exports = therapistRouter