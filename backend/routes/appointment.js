let express = require('express');
const ApplicationUser = require('../models/application_user');
let appointmentRouter = express.Router();



//cusomer route hadnling

appointmentRouter.get('/api/customer',async (req,res)=>{
    
    const councillors = await ApplicationUser.listCounciloors();
    res.json(councillors);
})

appointmentRouter.get('/api/get_time_slots/:userId',async (req,res)=>{
    const userId = req.params.userId;
    const councillors = await ApplicationUser.listtimeslots(userId);
    res.json(councillors);
})

appointmentRouter.post('/api/update_session/',async (req,res)=>{
    const {sessionId,userId} = req.body; // Destructure the session_id from the request body
    await ApplicationUser.updateSession(sessionId,userId);
})

appointmentRouter.get('/api/view_appointments/:userId',async (req,res)=>{
    const userId = req.params.userId;
    const appointments = await ApplicationUser.listAppointments(userId);
    res.json(appointments);
})

module.exports = appointmentRouter;

