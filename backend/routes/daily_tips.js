let express = require('express')
const pool = require('../database/dbconnection')
const imageUpload = require('../middleware/multer');
const { getByTipsDay } = require('../models/daily_tip');
const DailyTip = require('../models/daily_tip');
const {daily_tip} = require("../sequelize/models");


let dRouter = express.Router()


dRouter.post('/api/create-daily-tips',imageUpload.single('image'),async(req, res, next)=>{
    try{
       var result=  await daily_tip.create({
                day:req.body.day,
                text:req.body.text,
                content_location:req.file.filename,
            })

        res.send([result.dataValues.tip_id]);
        
    }
    catch(e){
        console.log(e)

    }
    next();
})

dRouter.get('/api/get-all-tips',async(req, res, next)=>{
    try{
        var result =  await daily_tip.findAll({

        })
        res.send(result)
    }
    catch(e){
        console.log(e)
    }
    next()
})

dRouter.get('/api/get-tips-by-day/:day',async(req, res, next)=>{
    try{
        var result =  await DailyTip.getByTipsDay(req.params.day);
        res.send(result)
    }
    catch(e){
        console.log(e)
    }
    next()
})

dRouter.get('/api/get-tips-by-id/:id',async(req, res, next)=>{
    try{
        var result =  await DailyTip.getTipsById(req.params.id);
        res.send(result)
    }
    catch(e){

    }
})







module.exports = dRouter