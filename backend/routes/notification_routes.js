let express = require('express')
const pool = require('../database/dbconnection')
const imageUpload = require('../middleware/multer')
const UserNotification = require('../models/user_notification')
const {mindfulness_course} = require('../sequelize/models')
const {notification} = require('../sequelize/models')

let nRouter = express.Router()


nRouter.post("/api/create-puser-notification", async(req, res, next)=>{
    try{
        UserNotification.createNotifcation(req)
    }
    catch(e){
        console.log(e)
    }
    next()
})

nRouter.get("/api/change-noti-status/:notiid/:status", async(req, res, next)=>{
    try{
        UserNotification.changeStatus(req.params.notiid, req.params.status)
    }
    catch(e){
        console.log(e)
    }
    next()
})

nRouter.get("/api/get-noti/:userid", async(req, res, next)=>{
    try{
        var result = await UserNotification.getNotification(req.params.userid)
        if(result==0){
            res.send([])
        }
        else{
            res.send(result)
        }
    }
    catch(e){
        console.log(e)
    }
    next()
})

nRouter.get("/api/get-end-task/:userid",async(req, res, next)=>{
    try{
        var result = await UserNotification.getSettedTasks(req.params.userid)
        res.send(result)
        
    }
    catch(e){
        console.log(e)
    }
    next()
})



module.exports = nRouter
