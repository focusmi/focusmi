const pool = require("../database/dbconnection");

const Schedule = {

  createSchedule: async (adminUserID, fee, sessionTime, sessionEndTime) => {
    try {
      const query = `INSERT INTO new_therapy_session ("admin_user_ID", fee, session_time, session_end_time) 
                     VALUES (${adminUserID}, ${fee}, '${sessionTime}','${sessionEndTime}')`;
      console.log(query)
      const insertedSchedule = await pool.cQuery(query);
      return insertedSchedule;
    } catch (error) {
      throw new Error('Error creating schedule:', error);
    }
  },

  getScheduleDateTime: async (userId) => {
    try { 
      const query = `SELECT * FROM new_therapy_session WHERE "admin_user_ID" = '${userId}'`;
      const scheduleDateTime = await pool.cQuery(query);
      return scheduleDateTime;
    } catch (error) {
      throw new Error('Error getting schedule data:', error);
    }
  },

  getScheduleDataForUser: async (userId) => {
    try {
      const query = `SELECT * FROM appointments WHERE admin_user_id = '${userId}'`;
      const scheduleData = await pool.cQuery(query);
      return scheduleData;
    } catch (error) {
      throw new Error('Error getting schedule data:', error);
    }
  },

  deleteScheduleData: async (scheduleID) => {
    try {
      const query = `DELETE FROM appointments WHERE '${scheduleID}' = $1`;
      await pool.cQuery(query);
      console.log('Schedule deleted successfully');
    } catch (error) {
      throw new Error('Error deleting schedule data:', error);
    }
  }
};

module.exports = Schedule;
