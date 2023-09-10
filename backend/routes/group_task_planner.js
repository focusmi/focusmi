let express = require('express');
const TaskGroup = require("../models/task_group");
const { isAuth } = require('../tokens/tokens');
const auth = require('../tokens/auth');
const { json } = require('body-parser');
const ApplicationUser = require('../models/application_user');
const { request } = require('http');
const TaskPlan = require('../models/taks_plan');
const Task = require('../models/task');
const {task_plan} = require('../sequelize/models');
const pool = require('../database/dbconnection');
const Blog = require('../models/blog');
let gTaskRoutes = express.Router();

//cusomer route hadnling

gTaskRoutes.get('/api/task-groups',auth,async(req,res,next)=>{
   try{
      var userID=req.user;
      userID =  ((userID)[0]).user_id
      if(userID != 0){
         var Group =new TaskGroup();
         Group.creator_id = userID;
         result =await Group.getTaskGroups(userID);
         res.status(200);
         res.json(result);
      }
   }
   catch (e){
      res.status(400);
      res.send({'msg':'User not verified'});
 
   }
   next();
})

gTaskRoutes.post('/api/create-group',async(req,res,next)=>{
   try{
      var taskGroup =new TaskGroup();
      taskGroup.createGroup(req.body)
      res.status(200).send("Successful") 

   }
   catch(e){
         console.log(e)
        res.status(400).send("User not verified");
        return ;
   }
   next();
})

gTaskRoutes.post('/api/add-group-user',async(req,res,next)=>{
   try{
       const userID = isAuth(req, res);
       console.log(userID);
       if(userID){
          
          var Group =new TaskGroup();
          var reqBody = req.body;
          Group.group_id= reqBody.group_id;
          
          var result = await Group.addGroupUser(reqBody.status,reqBody.user);
          if(result){
            res.status(200).send({"msg":"Successful"});
          }
          else{
            res.status(400).send({"msg":"User not added"});
          }
       }
       

   }
   catch{
        res.status(400).send({'msg':"User not verified"});
        return ;
   }
   next();
})

gTaskRoutes.get('/api/count-group-member',async( req,res,next)=>{
   try{
      const userID = isAuth(req,res)
      var Group =  new TaskGroup();
      var value = await Group.getGroupMemberCount(userID)
      return value;

   }
   catch(e){
      res.status(400).send({'msg':"An error occurred when fetching data"})

   }
})

gTaskRoutes.get('/api/get-group-members/:groupID',auth,async(req,res,next)=>{

   try{
      const userID = (req.user[0]).user_id;
      console.log(userID)
      const groupID = req.params.groupID
      if(userID ==0 ){
         return res.send({})
      }
      let taskGroup = new TaskGroup();
      let result = await taskGroup.getGroupMembers(groupID,userID)
      console.log(result)
      res.status(200).send(result);

   }
   catch(e){
      console.log(e);
      res.send({})
   }
})

gTaskRoutes.get('/api/add-group-member/:userid/:groupid',auth,(req, res, next)=>{
   const userid = req.params.userid;
   const groupid = req.params.groupid;
  
   try{
      let Group = new TaskGroup();
      Group.addGroupUser(groupid,userid);
      res.status(200).send(true)

   }
   catch(e){
      console.log(e)
      res.status(400).send({msg:"Cannot add group member"})
   }
   next();
})

gTaskRoutes.post('/api/add-task',auth,async(req, res, next)=>{
   try{
      Task.createTask(req.body)
      
   }
   catch(e){
      print(e)
   }
})

gTaskRoutes.get('/api/search-group-member',auth,async(req, res, next)=>{
   try{
  
      var userid = (req.user[0]).user_id;
      var applicationUser =new ApplicationUser();
      var result =await applicationUser.getUser(req.query.search , userid);
      res.status(200).send(result)
   }
   catch(e){
      console.log(e);
      res.status(400).json([{}])
   }
   next();
})

gTaskRoutes.get('/api/remove-group-member/:userid/:groupid',auth,async(req, res, next)=>{
   const userid = req.params.userid;
   const groupid = req.params.groupid;
  
   try{
      let Group = new TaskGroup();
      Group.removeGroupUser(groupid,userid);
      res.status(200).send(true)

   }
   catch(e){
      console.log(e)
      res.status(400).send({msg:"Cannot remove group member"})
   }
   next();
})

gTaskRoutes.post('/api/create-task-plan',auth,async(req, res, next)=>{
   try{
      var userID=req.user;
      userID =  ((userID)[0]).user_id
      const taskPlan = new TaskPlan();
      var result = await taskPlan.createTaskPlan(req.body,userID)
      res.status(200).json({'plan_id':result.dataValues.plan_id})
   }
   catch(e){
      console.log(e)
      res.status(400).send(false)

   }
   next()

})

gTaskRoutes.post('/api/rename-task-plan',auth,(req , res, next)=>{
   try{
      const taskPlan = new TaskPlan()
      console.log(req.body.plan_id+"------"+req.body.plan_name)
      taskPlan.renameTaskPlan(req.body.plan_id,req.body.plan_name)
   }
   catch(e){
      console.log(e)

   }
   next()
})

gTaskRoutes.get('/api/get-plan-task/:planid',auth,async(req,res,next)=>{
   try{
      var result = await Task.getPlanTask(req.params.planid)
      res.status(200).send(result)
   }
   catch(e){
      console.log(e)
      res.send(400).send({})
   }
   next()
})

gTaskRoutes.post('/api/update-task-name/',auth,async(req,res,next)=>{
   try{
      var result =await Task.updateTask(req.body.user_id, 'task_name', req.body.task_name)
      res.status(200).send(result)
   }
   catch(e){
      console.log(e)
      res.send(400).send({})
   }
   next()
})

gTaskRoutes.post('/api/delete-task-plan/:planid',auth,async(req, res, next)=>{
   try{
      var result = await task_plan.destroy({plan_id:req.params.planid})
   }
   catch(e){
      console.log(e)
   }
   next() 
})

gTaskRoutes.get('/api/get-task-plan-by-group/:groupid',auth, async(req,res,next)=>{
   try{ 
      var result = await TaskPlan.getTaskPlanByGroup(req.params.groupid)
      res.status(200).send(result)
   }
   catch(e){
      console.log(e)
      res.status(400).send(false)
   }
   next()
})

gTaskRoutes.post('/api/create-task',auth, async(req, res, next)=>{
   try{
      Task.createTask(req.body)

   }
   catch(e){
      console.log(e)
   }
   next()
})

gTaskRoutes.get('/api/get-recent-task-by-user',auth,async(req, res, next)=>{
   var userID=req.user;
   console.log("Error")
   console.log(userID)
   userID =  ((userID)[0]).user_id
  try{
      var result = await task_plan.findAll({
         where:{
            user_id:userID
         },
         order:[
            ['updated_at','DESC']
         ]
      
      })
      res.send(result)
  }
  catch(e){

  } 
  next()
})

gTaskRoutes.get('/api/get-all-blogs',auth, async(req, res, next)=>{
   var userID = req.user;
   userID = ((userID)[0]).user_id
   try{
      var result = await Blog.getAllBlogs()
      res.send(result)
   }
   catch(e){
      console.log(e)
   }
   next()
})

gTaskRoutes.post('/api/create-blog',auth,async(req, res, next)=>{
   console.log("hit")
   var userID = req.user;
   userID = ((userID)[0]).user_id
   try{
      var result = await Blog.createBlog(req.body)
      res.send(result)
   }
   catch(e){
      console.log(e)
      res.send(false)
   }
   next()
})

module.exports = gTaskRoutes;