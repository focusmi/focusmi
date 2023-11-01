const { unstable_createStaticHandler } = require('@remix-run/router')
let express = require('express')
const pool = require('../database/dbconnection')
const imageUpload = require('../middleware/multer')
const CourseUser = require('../models/course_user')
const {mindfulness_course, course_level, application_user} = require('../sequelize/models')
const auth = require('../tokens/auth')

let mRouter = express.Router()
/* ----------------------------------------*/
//course-types meditation, stress relief, sleep well, focus, realtionship, applied mindfulness
//subscribe_type free, paid
//course status published, drafted
mRouter.post('/api/create-course',imageUpload.single('image'),async(req, res, next)=>{
    try{
        var result=await mindfulness_course.create({
          title:req.body.title,
          description:req.body.description,
          skill:req.body.skill,
          duration:req.body.duration,
          rating:req.body.rating,
          image:req.file.filename,
          course_status:"drafted",
          subscription_type:req.body.subscription_type,
          course_type:req.body.course_type  
        })
        //result come as [courseid]
        res.send([result.dataValues.course_id])
   
    }
    catch(eq){
        console.log(eq)
        console.log("create course")
    }
    next()
})

mRouter.get('/api/get-course/:courseid',async(req, res, next)=>{
    console.log(req.params.courseid)
    try{
        var result = await mindfulness_course.findOne({
            where:{
                course_id:req.params.courseid

            }
        })
       
        res.send(result)
   
    }
    catch(eq){
        console.log("create course")
    }
    next()
})

mRouter.get('/api/publish-course/:courseid',(req, res, next)=>{
    try{
        mindfulness_course.update({course_status:'published'},{
            where:{
                course_id:req.params.courseid
            }
        })
    }
    catch(e){

    }
    next()
})

mRouter.get('/api/draft-course/:courseid',(req, res, next)=>{
    try{
        mindfulness_course.update({course_status:'drafted'},{
            where:{
                course_id:req.params.courseid
            }
        })
    }
    catch(e){

    }
    next()
})


mRouter.post('/api/update-course/:courseid'  , async(req, res, next)=>{
    try{
        
        
                mindfulness_course.update({
                    title:req.body.title,
                    description:req.body.description,
                    

                },{
                    course_id:req.params.courseid
                })
        
        }
    
    catch(e){
        console.log(e)
    }
    next()
})
mRouter.post('/api/update-course-level'  , async(req, res, next)=>{
    try{
        let pos = 0;
        for(const key in req.body){
            if(pos!=0  && req.body[`'${key}'`]!=null){
                mindfulness_course.update({key:req.body[`'${key}'`]},{
                    course_id:req.body.course_id
                })
                
            }
            pos++
        }
    }
    catch(e){
        console.log(e)
    }
    next()
})

//get courses by category if -> localhost/api/get-all-courses/meditation will give all the courses with type meditation
mRouter.get('/api/get-all-courses/:category',async(req, res, next)=>{
    try{
        var course = await mindfulness_course.findAll({
            where:{
                course_type:req.params.category
            }
        })
        res.send(course)
    }
    catch(e){
        console.log("get courses by category")
    }
    next()
})

mRouter.get('/api/get-all-courses',async(req, res, next)=>{
    try{
        var course =await pool.cQuery("Select * from mindfulness_course ")
        res.send(course)

    }
    catch(e){
        console.log("get all courses")
    }
    next()
})

mRouter.get('/api/get-all-featured-courses',async(req, res, next)=>{
    try{
        var course =await pool.cQuery("Select * from mindfulness_course where course_status='published' order by ratings desc")
        res.send([course[0]])

    }
    catch(e){
        console.log("get courses by category")
    }
    next()
})

mRouter.get("/api/create-course-user/:userid/:courseid", async(req, res, next)=>{
    try{
        CourseUser.allocateCourseUser(req.params.userid, req.params.courseid)
    }
    catch(e){

    }
    next()
})

mRouter.post('/api/create-course-level',imageUpload.single('audio'),async(req, res, next)=>{

    try{
        var result = await course_level.create({
            course_id:req.body.course_id,
            level_name:req.body.level_name,
            level_description:req.body.level_description,
            reference:req.body.reference,
            media_type:req.body.media_type,
            content_location:req.file.filename
        })
        res.send([result.dataValues.level_id])
   
    }
    catch(eq){
        console.log(eq)
        console.log("create course level")
    }
    next()
})

mRouter.get('/api/get-course-level/:courseid',  async(req, res, next)=>{
    try{
       var result =  await course_level.findAll({
            where:{
                course_id:req.params.courseid
            }
       }) 
       res.send(result)
    }
    catch(e){
        console.log(e)
        console.log("create course level")
    }
    next()
})

mRouter.get('/api/get-course-levels/:courseid',  async(req, res, next)=>{
    try{
       var result =  await course_level.findAll({
            where:{
                course_id:req.params.courseid
            }
       }) 
       res.send(result)
    }
    catch(e){
        console.log(e)
        console.log("create course level")
    }
    next()
})

mRouter.get('/api/get-course-level-by-courselevel/:level',  async(req, res, next)=>{
    try{
       var result =  await course_level.findOne({
            where:{
                level_id:req.params.level
            }
       }) 
       res.send(result)
    }
    catch(e){
        console.log(e)
        console.log("create course level")
    }
    next()
})

mRouter.get('/api/get-similar-courses/:coursetype', auth,async(req, res, next)=>{
    try{
        var result = await mindfulness_course.findAll({
            where:{
                course_type:req.params.coursetype
            }
        })
        result = result.map(course => course.dataValues);
        res.send(result)
    }
    catch(e){

    }
    next()
})

mRouter.get('/api/get-similar-courses/:coursetype', auth,async(req, res, next)=>{
    try{
        var result = await mindfulness_course.findAll({
            where:{
                course_type:req.params.coursetype
            }
        })
        result = result.map(course => course.dataValues);
        res.send(result)
    }
    catch(e){

    }
    next()
})

mRouter.get('/api/get-similar-courses/:coursetype', auth,async(req, res, next)=>{
    try{
        var result = await mindfulness_course.findAll({
            where:{
                course_type:req.params.coursetype
            }
        })
        result = result.map(course => course.dataValues);
        res.send(result)
    }
    catch(e){

    }
    next()
})

mRouter.get('/api/set-user-package/:package/:userid',async(req, res, next)=>{
    try{
        var result = await application_user.update(
            {account_status:req.params.package},{
                where:{
                    user_id:req.params.userid
                }
            }
        )
        result = result.map(course => course.dataValues);
        res.send(result)
    }
    catch(e){

    }
    next()
})

mRouter.get('/api/get-user-package/:userid',async(req, res, next)=>{
    try{
        console.log("Dfd")
        var result = await pool.cQuery(`select account_status from application_user where user_id=${req.params.userid}`)
        if(result==0){
            res.send([])
        }
        else{
            res.send(result)
        }
    }
    catch(e){

    }
    next()
})



module.exports = mRouter
