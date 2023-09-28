let express = require('express')
const imageUpload = require('../middleware/multer')
const {mindfulness_course} = require('../sequelize/models')

let mRouter = express.Router()


mRouter.post('/api/create-course',imageUpload.single('image'),(req, res, next)=>{
    try{
        mindfulness_course.create({
          title:req.body.title,
          description:req.body.description,
          skill:req.body.skill,
          duration:req.body.duration,
          rating:req.body.rating,
          image:req.body.image,
          course_status:req.body.course_status,
          subscription_type:req.body.subscription_type,
          course_type:req.body.course_type  
        })
    }
    catch(e){
        console.log("create course")
    }
})

mRouter.get('/api/get-all-courses/:category',imageUpload.single('image'),async(req, res, next)=>{
    try{
        var course = await mindfulness_course.findAll({
            where:{
                course_type:req.params.category
            }
        })
        return course
    }
    catch(e){
        console.log("get courses by category")
    }
})

module.exports = mRouter