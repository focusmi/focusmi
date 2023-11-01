const express = require('express');
const ScheduleRouter = express.Router();
const Schedule = require('../models/schedule');
const auth = require('../middleware/auth');

ScheduleRouter.get('/apis/schedule/:userId', auth, async (req, res) => {
  try {
    const userId = req.params.userId;
    const scheduleData = await Schedule.getScheduleDataForUser(userId);
    res.json(scheduleData);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

ScheduleRouter.post('/apis/schedule/create/:userId', auth, async (req, res) => {
  try {
    const { start, end } = req.body;
    const userId = req.params.userId;
    const newSchedule = await Schedule.createSchedule(userId,50,start,end);
    res.json(newSchedule);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

ScheduleRouter.get('/apis/schedule/time/:userId', auth, async (req, res) => {
  try {
    const userId = req.params.userId;
    const scheduleDateTime = await Schedule.getScheduleDateTime(userId);
    res.json(scheduleDateTime);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

ScheduleRouter.put('/apis/schedule/complete/:appointmentId', auth, async (req, res) => {
  try {
    const appointmentId = req.params.appointmentId;
    await Schedule.completeAppointment(appointmentId);
    res.json({ success: true, msg: 'Appointment successfully!' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

ScheduleRouter.get('/apis/schedule/count/:userId', auth, async (req, res) => {
  try {
    const userId = req.params.userId;
    const scheduleCount = await Schedule.getScheduleCount(userId);
    let count = scheduleCount[0].count
    res.json(count);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = ScheduleRouter;