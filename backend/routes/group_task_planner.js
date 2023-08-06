let express = require('express');
const TaskGroup = require("../models/task_group");
const { isAuth } = require('../tokens/tokens');
const auth = require('../tokens/auth');
const { json } = require('body-parser');
const ApplicationUser = require('../models/application_user');
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
      console.log(e)
      res.status(400);
      res.send({'msg':'User not verified'});
 
   }
   next();
})

gTaskRoutes.post('/api/create-group',async(req,res,next)=>{
   try{
       const userID = isAuth(req, res);
       var Group =new TaskGroup();
       var reqBody = req.body;
       Group.group_name = reqBody.group_name;
       Group.status = reqBody.status;
       Group.creator_id=userID;
       var result = await Group.createGroup();
       

   }
   catch{
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
   console.log("reached")
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


module.exports = gTaskRoutes;