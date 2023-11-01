let express = require('express')
const { ResultWithContextImpl } = require('express-validator/src/chain')
const pool = require('../database/dbconnection')
const imageUpload = require('../middleware/multer')
const {mindfulness_course} = require('../sequelize/models')
const blog = require('../sequelize/models/blog')

let bRouter = express.Router()

bRouter.post('/api/create-blog', auth, async(req, res, next)=>{
    console.log("dfdfdf")
    try{
        var userID = req.user;
        userID = ((userID)[0]).user_id
        blog.create({
            status:"draft",
            user_id:userID,
            title:req.body.title,
            subtitle:req.body.subtitle,
            description:req.body.description
        })
    }
    catch(e){

    }
    next();
})

bRouter.get('/api/get-blogs-by-user/:userid',auth, async(req, res, next)=>{
    try{
        var result = await blog.findAll({where:{
            user_id:req.params.userid
        }})
        return result.dataValues;
    }
    catch(e){

    }
    next()
})

bRouter.post('/api/update-blog-status/:blogid/:status', auth, async(req, res, next)=>{
    try{
        var userID = req.user;
        userID = ((userID)[0]).user_id
        blog.update({
            status:req.params.status
        },
        {
            where:{
                blog_id:req.params.blogid
            }
        }
        
        )
    }
    catch(e){

    }
    next();
})







module.exports = bRouter