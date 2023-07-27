const pool = require("../database/dbconnection");

const Schedule = {
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
