let express = require('express');
let appointmentRouter = express.Router();
const AUser = require('../models/application_user');

//cusomer route hadnling

appointmentRouter.get('/api/customer',async (req,res)=>{
    const councillors = await AUser.listCounciloors();
    res.json(councillors);
})

appointmentRouter.get('/api/get_time_slots/:userId',async (req,res)=>{
    const userId = req.params.userId;
    const councillors = await AUser.listtimeslots(userId);
    res.json(councillors);
})

appointmentRouter.post('/api/update_session/:userId',async (req,res)=>{
    const {sessionId,userId} = req.body; // Destructure the session_id from the request body
    await AUser.updateSession(sessionId,userId);
})


module.exports = appointmentRouter;

