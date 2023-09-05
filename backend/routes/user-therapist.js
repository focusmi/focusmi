let express = require('express')
const { RowDescriptionMessage, CommandCompleteMessage } = require('pg-protocol/dist/messages')
const { UNSAFE_NavigationContext } = require('react-router-dom')
const User = require('../models/therapist')
const UserTherapist = require('../models/user-therapist')
let userAuthRouter = express.Router()

userAuthRouter.post('/api/create-therapist/:name', async(req,res,next) => {
    try{
        UserTherapist.createTherapist(req.body)
        res.status(400).send(true)
    }
    catch(e){
        console.log(e)
        res.status(400).send(false)
    }
    next()
})

userAuthRouter.get('/api/get-therapist/', async(req,res,next)=>{
    try{
        var result =  await UserTherapist.getTherapist()
        res.status(400).send(result)
    }
    catch(e){
        console.log(e)
        res.status(400).send([])
    }
    next()
})

userAuthRouter.post('/api/update-user', async(req, res, next)=>{
    try{
        UserTherapist.updateuser(req.body.user_id, req.body)
        res.status(400).send(true)
    }
    catch(e){
        console.log(e)  ``
        res.status(400).send(false)
    }
})

userAuthRouter.get('/api/delet-user/:userid',async(req,res,next)=>{
    try{
        UserTherapist.deleteuser(req.params.userid)
        res.status(400).send(true)
    }
    catch(e){
        console.log(e)
        req.status(400).send(false)
    }
    next()
})






router.get('/error',(req,res)=>{
    throw new Error("This is a forced error")
})
module.exports = mRouter