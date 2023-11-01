const pool = require("../database/dbconnection");

const Schedule = {

  createSchedule: async (adminUserID, fee, sessionTime, sessionEndTime) => {
    try {
      const query = `INSERT INTO therapy_session ("user_id", fee, session_time, session_end_time,booking_status) 
                     VALUES (${adminUserID},${fee},'${sessionTime}','${sessionEndTime}','false')`;
      const insertedSchedule = await pool.cQuery(query);
      return insertedSchedule;
    } catch (error) {
      throw new Error('Error creating schedule:', error);
    }
  },

  getScheduleDateTime: async (userId) => {
    try {
      const query = `SELECT * FROM therapy_session WHERE "user_id" = '${userId}'`;
      const scheduleDateTime = await pool.cQuery(query);
      return scheduleDateTime;
    } catch (error) {
      throw new Error('Error getting schedule data:', error);
    }
  },

  getScheduleDataForUser: async (userId) => {
    try {
      const query = `SELECT
      a."appointment_id",
      a."user_id",
      a."session_id",
      a."complete",
      u."username",
      u."account_status",
      u."full_name",
      u."email",
      s."session_time",
      s."session_end_time"
  FROM
      appointment AS a
  JOIN
      therapy_session AS s ON a."session_id" = s."session_id"
  JOIN
      application_user AS u ON a."user_id" = u."user_id"
  WHERE
      s."user_id" = ${userId}
  `;
      const scheduleData = await pool.cQuery(query);
      return scheduleData;
    } catch (error) {
      throw new Error('Error getting schedule data:', error);
    }
  },

  deleteScheduleData: async (scheduleID) => {
    try {
      const query = `DELETE FROM appointment WHERE '${scheduleID}' = $1`;
      await pool.cQuery(query);
      console.log('Schedule deleted successfully');
    } catch (error) {
      throw new Error('Error deleting schedule data:', error);
    }
  },

  completeAppointment: async (appointmentId) => {
    try {
      const query = `UPDATE appointment SET "complete" = 'true' WHERE  "appointment_id" = '${appointmentId}'`;
      await pool.cQuery(query);
      console.log('Appointment complete successfully');
    } catch (error) {
      throw new Error('Error completing appointment:', error);
    }
  },

  getScheduleCount: async (userId) => {
    try {
        const query = `SELECT
        COUNT(a."appointment_id")
          FROM
              appointment AS a
          JOIN
              therapy_session AS s ON a."session_id" = s."session_id"
          JOIN
              application_user AS u ON a."user_id" = u."user_id"
          WHERE
              s."user_id" = ${userId} AND a."complete" = 'false'
    `;
        const scheduleCount = await pool.cQuery(query);
        return scheduleCount;
      } catch (error) {
        throw new Error('Error getting schedule count data:', error);
      }
  },

};

module.exports = Schedule;