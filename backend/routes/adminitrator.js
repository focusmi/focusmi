let express = require('express')
const { RowDescriptionMessage, CommandCompleteMessage } = require('pg-protocol/dist/messages')
const { UNSAFE_NavigationContext } = require('react-router-dom')
const ApplicationUser = require('../models/application_user')
const User = require('../models/therapist')
const UserTherapist = require('../models/user-therapist')
let userTRoutes = express.Router()
const auth = require('../tokens/auth');

userTRoutes.post('/api/create-therapist', async(req,res,next) => {
    try{
        UserTherapist.createTherapist(req.body)
        res.status(200).send(true)
    }
    catch(e){
        console.log(e)
        res.status(400).send(false)
    }
    next()
})

userTRoutes.get('/api/get-therapist', async(req,res,next)=>{
    try{
        var result =  await UserTherapist.getTherapist()
        res.status(200).send(result)
    }
    catch(e){
        console.log(e)
        res.status(200).send([])
    }
    next()
})

userTRoutes.post('/api/update-therapist', async(req, res, next)=>{
    
    try{
        UserTherapist.updateuser(req.body.user_id, req.body)
        res.status(200).send(true)
    }
    catch(e){
        console.log(e)  ``
        res.status(200).send(false)
    }
})

userTRoutes.get('/api/delete-therapist/:userid',async(req,res,next)=>{
    try{
        UserTherapist.deleteuser(req.params.userid)
        res.status(200).send(true)
    }
    catch(e){
        console.log(e)
        req.status(200).send(false)
    }
    next()
})

userTRoutes.get('/api/get-app-wide-user-detail',auth,async(req, res, next)=>{
    if((req.user[0]).user_id != 0){
        try{
            var result = ApplicationUser.getUserDetail()
            res.send(result)
        }
        catch(e){
            console.log(e)
        }
    }
    next()
})







module.exports = userTRoutes