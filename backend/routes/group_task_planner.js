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
const {task, sub_task, application_user} = require('../sequelize/models');
const pool = require('../database/dbconnection');
const Blog = require('../models/blog');
const PomodoroTimer = require('../models/pomodoro_timer');
const SubTask = require('../models/sub_task');
const { runInNewContext } = require('vm');
const { Op } = require('sequelize');
const UserChat = require('../models/user_chat');
const { copyFileSync } = require('fs');
const { addMessage } = require('../models/user_chat');
let gTaskRoutes = express.Router();

//cusomer route hadnling


gTaskRoutes.get('/api/get-user-by-id/:userid',auth,async(req,res,next)=>{
   try{
      var result = await application_user.findOne({
         user_id:req.params.userid
      })
      res.send([result])
   }
   catch (e){
      res.status(400);
      res.send({'msg':'User not verified'});
 
   }
   next();
})


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

gTaskRoutes.get('/api/get-task-groupsa/:groupid',async(req,res,next)=>{
   try{
      var result =await pool.cQuery(`select * from task_group where group_id=${req.params.groupid}`)
      console.log("lllll")
      console.log(req.params.groupid)
      if(result==0){
         res.send([])
      }
      else{
         res.send(result)
      }
   }
   catch (e){
      res.status(400);
      res.send({'msg':'User not verified'});
 
   }
   next();
})



gTaskRoutes.get('/api/change-prevs/:userid/:groupid/:prev',auth,async(req,res,next)=>{
   try{
      TaskGroup.editGroupUser(req.params.groupid,req.params.userid,req.params.prev)
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
     //  const userID = isAuth(req, res);
   //
          
          var Group =new TaskGroup();
          var reqBody = req.body;
          Group.group_id= reqBody.group_id; 
          var result = await Group.addGroupUser(reqBody.group_id,reqBody.user);
          if(result){
            res.status(200).send({"msg":"Successful"});
          }
          else{
            res.status(400).send({"msg":"User not added"});
          }
    //   }
       

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

gTaskRoutes.get('/api/get-group-members-by-task/:taskID',auth,async(req,res,next)=>{
   var id = (req.user)[0]
   id = id.user_id;
   try{
      var result = await task.findOne({task_id:req.params.taskID});
      result = await task_plan.findOne({plan_id:result.dataValues.plan_id})
      result = await pool.cQuery(`Select * from application_user left join group_user on group_user.user_id=application_user.user_id where group_id=${result.dataValues.group_id} and application_user.user_id<>${id}`)
      if(result==0){
         res.send([])
      }
      else{
         res.send(result)

      }
   }
   catch(e){
      console.log(e);
      res.send([])
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
      Task.createTask({
         plan_id:req.body.plan_id,
         timer_id:0,
         duration:0,
         task_status:'pending',
         priority:req.body.priority,
         
         
      })     
   }
   catch(e){
      console.log(e)
   }
})

gTaskRoutes.get('/api/get-chat-by-group/:groupid',auth,async(req, res, next)=>{
   try{
     var result = await UserChat.getChatByGroup(req.params.groupid)    
     res.send([result])
   }
   catch(e){
      console.log(e)
   }
   next()
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

gTaskRoutes.get('/api/get-task-by-plan/:planid',auth,async(req, res, next)=>{
   const planid = req.params.planid;  
   try{
      var task = await Task.getPlanTask(planid)
      res.send(task)
   }
   catch(e){
      console.log(e)
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


gTaskRoutes.get('/api/get-task-by-plan-user/:planid',auth,async(req,res,next)=>{
   var user = (req.user)[0];
   try{
      var result = await Task.getPlanTaskByUser(req.params.planid,user.user_id)
      res.status(200).send(result)
   }
   catch(e){
      console.log(e)
      res.send(400).send({})
   }
   next()
})

gTaskRoutes.get('/api/get-task-by-iplan-user/:planid',auth,async(req,res,next)=>{
   var user = (req.user)[0];
   try{
      var result = await Task.getiPlanTaskByUser(user.user_id)
      if(result == 0){
         res.status(200).send([])
      }
      else{
         res.status(200).send(result)

      }
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
      console.log("-----------------------------")
      console.log(result)
      console.log("-----------------------------")
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

gTaskRoutes.post('/api/chanage-task-color', auth, async(req, res, next)=>{
   var userID = req.user;
   userID = ((userID)[0]).user_id
   try{
      Task.addColor(req.body.task_id, req.body.color)
      res.send(true)
   }
   catch(e){
      console.log(e)

   }
   next()
})

gTaskRoutes.get('/api/set-task-attr/:task/:attr/:val',auth, async(req, res, next)=>{
   var userID = req.user;
   try{
      
      Task.setAttribute(req.params.attr,req.params.task,req.params.val)
      res.send(true)
   }
   catch(e){
      console.log(e)
   }
   next()
})

gTaskRoutes.get('/api/get-task-attr/:task/:attr',auth, async(req, res, next)=>{
   var userID = req.user; 
   console.log(req.params.attr)
   try{
      var val = await task.findOne(
         {
            where:{
               task_id:req.params.task
            }
         });
         console.log("===")
      console.log(val)
      if(val==null){
         res.send({value:null})
         
      }
      else{
       
         val =  val[`${req.params.attr}`]
         res.send({value:val})

      }
   }
   catch(e){
      console.log(e)
   }
   next()
})

gTaskRoutes.get('/api/set-timer-attr/:attr/:value/:user', auth ,async(req, res, next)=>{
   console.log(req.params.value)
   try{
      PomodoroTimer.attrSetter(req.params.attr, req.params.value, req.params.user)
   }
   catch(e){
      console.log("Route Error - set timer attributes")
      console.log(e)

   }
   next()
})

gTaskRoutes.get('/api/reduce-turns/:userid',async(req, res, next)=>{
   console.log("redusing")
   try{
      var result = await PomodoroTimer.attrGetter("rturns",req.params.userid)
      console.log(result-1)
      PomodoroTimer.attrSetter("rturns",result-1,req.params.userid)
   }
   catch(e){
      console.log("Route Error - set timer attributes")
      console.log(e)

   }
   next()
})

// gTaskRoutes.get('/api/get-timer-attr2/:attr/:user',async(req, res, next)=>{
//    try{
//       var result =  await PomodoroTimer.attrGetter(req.params.attr, req.params.user)
//       res.send([result])
//    }
//    catch(e){
//       console.log("Route Error - set timer attributes")
//       console.log(e)

//    }
//    next()
// })

gTaskRoutes.post('/api/create-timer', auth, async(req, res, next)=>{

   try{
      PomodoroTimer.createTimer(req.body)

   }
   catch(e){
      console.log("Route Error - create timer")
      console.log(e)

   }
   next()
})

gTaskRoutes.get('/api/get-timer-attr/:user/:attr', async(req, res, next)=>{
   try{
      console.log("inside the routes");
      console.log(req.params.attr)
      var result = await PomodoroTimer.attrGetter(req.params.attr, req.params.user)
      res.send({'value':result})
   }
   catch(e){

      console.log("Route Error - get timer attribute")
      console.log(e)
   }



})

gTaskRoutes.post('/api/create-subtask', auth, async(req, res, next)=>{
   console.log("inside create subtask")
   try{
      SubTask.createSubTask(req.body) 
   }
   catch(e){
      console.log("creating sub task")
      console.log(e)
   }
   next();
})

gTaskRoutes.get('/api/set-subtask-attr/:type/:staskid/:value', auth , async(req, res, next)=>{
   try{     
      SubTask.setSubTaskAttr(req.params.type, req.params.staskid, req.params.value)
   }
   catch(e){
      console.log("task attribute")
   }
   next()
})

gTaskRoutes.get('/api/get-stask-attr/:task/:attr',auth, async(req, res, next)=>{
   var userID = req.user; 
   console.log(req.params.attr)
   try{
      var val = await task.findOne(
         {
            where:{
               stask_id:req.params.task
            }
         });
      val =  val[`${req.params.attr}`]
      res.send({value:val})
   }
   catch(e){
      console.log(e)
   }
   next()
})

gTaskRoutes.get('/api/get-all-sub-task/:taskid', auth, async(req, res, next)=>{
   try{
      var subtask=await pool.cQuery(`Select * from sub_task where task_id=${req.params.taskid} and sub_status='pending'`);
      
      var result = subtask
      if(result ==0){
         res.send([]);
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

gTaskRoutes.get('/api/update-sub-task/:staskid/:status', auth, async(req, res, next)=>{
   try{
      sub_task.update({sub_status:req.params.status},{
         where:{
            stask_id:req.params.staskid
         }
      })
   }
   catch(e){
      console.log(e)
   }
   next()
})

gTaskRoutes.get('/api/allocate-subtask-users/:task_id/:user_id',auth ,async(req, res, next)=>{
   
   try{
      SubTask.allocateTaskUser(req.params.task_id, req.params.user_id)

   }
   catch(e){
      console.log(e)
      console.log("allocate sub task user error")

   }
   next()
})

gTaskRoutes.get('/api/get-subtask-users/:taskid', auth , async(req, res, next)=>{
   try{
      var result = await SubTask.getAllocatedUsers(req.params.taskid)
      res.send({'value':result});
   }
   catch(e){
      console.log(e)
      console.log("get sub task users")
   }
   next()
})

gTaskRoutes.get('/api/allocate-task-users/:taskid/:userid',auth ,async(req, res, next)=>{
   try{
      Task.allocateTaskUser(req.params.taskid, req.params.userid)
   }
   catch(e){
      console.log(e)
      console.log("allocate sub task user error")

   }
   next()
})

gTaskRoutes.get('/api/get-task-users/:taskid', auth , async(req, res, next)=>{
   try{
      var result = await Task.getAllocatedUsers(req.params.taskid)
      res.send({'value':result});
   }
   catch(e){
      console.log(e)
      console.log("get sub task users")
   }
   next()
})

gTaskRoutes.get('/api/get-plan-by-plan/:planid', async(req, res, next)=>{
   try{
      var result = await task_plan.findOne({
         where:{
            plan_id:req.params.planid
         }
      })
      result = await task_plan.findAll({
         where:{
            group_id:result.dataValues.group_id,
            plan_id:{[Op.not] : result.dataValues.plan_id}

         }
      })
      //result = result[0].group_id
      if(result == null){
         res.send(0)
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

gTaskRoutes.get('/api/create-chat/:groupid', auth, async(req, res, next)=>{
   try{
      UserChat.createChat(req.params.groupid)
   }
   catch(e){
      console.log("Error in create chat")
      console.log(e)
   }
   next()
})

gTaskRoutes.post('/api/add-chat-message', auth, async(req, res, next)=>{
   try{
      UserChat.addMessage(req.body)
   }
   catch(e){
      console.log(e)
      console.log("Error in adding message")
   }
   next()
})

gTaskRoutes.get('/api/get-chat-message/:groupid', auth,  async(req, res, next)=>{
   try{
     var result = await UserChat.getChatMessage(req.params.groupid)
      if(result==0){
         res.send([])
      }
      else{

         res.send(result)
      }
   }
   catch(e){
      console.log("Error in get chat message")
      console.log(e)
   }
   next()
})

//gTaskRoutes.get('/api/create-daily-tips')





module.exports = gTaskRoutes;