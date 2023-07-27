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

module.exports = ScheduleRouter;
