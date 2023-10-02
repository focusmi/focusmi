let express = require('express')
const pool = require('../database/dbconnection')
const imageUpload = require('../middleware/multer')
const {mindfulness_course} = require('../sequelize/models')

let mRouter = express.Router()
/* ----------------------------------------*/
//course-types meditation, stress relief, sleep well, focus, realtionship, applied mindfulness
//subscribe_type free, paid
//course status published, drafted
mRouter.post('/api/create-course',imageUpload.single('image'),(req, res, next)=>{
    try{
        mindfulness_course.create({
          title:req.body.title,
          description:req.body.description,
          skill:req.body.skill,
          duration:req.body.duration,
          rating:req.body.rating,
          image:req.file.filename,
          course_status:req.body.course_status,
          subscription_type:req.body.subscription_type,
          course_type:req.body.course_type  
        })
   
    }
    catch(eq){
        console.log("create course")
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

module.exports = mRouter
