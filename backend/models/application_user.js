const { Op } = require("sequelize");
const pool = require("../database/dbconnection");
const { application_user } = require("../sequelize/models");


class ApplicationUser {

    constructor(email, password, username) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.id = '';

    }

    async getUser(searchname, userid) {
        var result = await application_user.findAll({
            where: {
                email: { [Op.like]: `%${searchname}%` },
                user_id: { [Op.not]: userid }
            }
        })
        return result
    }

    static listCounciloors = async () => {
        try {
            const query = `SELECT * FROM  administrative_user
            ORDER BY user_id ASC`;
            const users = await pool.cQuery(query);
            console.log(users)
            return users;
        } catch (error) {
            throw new Error('Error Finding Councillors:', error);
        }
    }

    static listAppointments = async (userId) => {
        try {
            const query = `SELECT * FROM  appointment WHERE user_id=${userId}`;
            const users = await pool.cQuery(query);
            console.log("[][][][]")
            console.log(users)
            return users;
        } catch (error) {
            throw new Error('Error Finding Councillors:', error);
        }
    }

    static listAppointmentDetails = async (sessionId) => {
        try {
            const query = `SELECT * FROM  therapy_session WHERE session_id=${sessionId}`;
            const users = await pool.cQuery(query);
            return users;
        } catch (error) {
            throw new Error('Error Finding Councillors:', error);
        }
    }

    static listCouncillorDetails = async (userId) => {
        try {
            console.log("Dfdf")
            const query = `SELECT full_name FROM  administrative_user WHERE user_id=${userId}`;
            const users = await pool.cQuery(query);
            return users;
        } catch (error) {
            throw new Error('Error Finding Councillors:', error);
        }
    }

    static listtimeslots = async (userId) => {
        try {

            const query = `SELECT * FROM therapy_session WHERE user_id=${userId} AND booking_status='false'`;
            console.log(query)
            const slot_list = await pool.cQuery(query);
            console.log(slot_list)
            return slot_list;

        } catch (error) {

            throw new Error('Error Finding Councillors:', error);
        }
    }
    static listPreviousAppointments= async (userId) => {
        try {
          const query = `SELECT
          s."session_time",
          s."session_end_time"
      FROM
          public.appointment AS a
      JOIN
          public.therapy_session AS s ON a."session_id" = s."session_id"
      WHERE
          a."user_id" = ${userId}
      `;
          const scheduleData = await pool.cQuery(query);
          console.log(query)
          return scheduleData;
        } catch (error) {
          throw new Error('Error getting schedule data:', error);
        }
      }


  static listAppointments= async (userId) => {
        try {
            const query = `SELECT
            s."session_time",
            s."fee",
            s."session_end_time",
            u."full_name"
        FROM
            public.appointment AS a
        JOIN
            public.therapy_session AS s ON a."session_id" = s."session_id"
        JOIN
            public.administrative_user AS u ON s."user_id" = u."user_id"
        WHERE
            a."user_id" = ${userId}
        `;
            const scheduleData = await pool.cQuery(query);
            return scheduleData;
        }catch (error) {
          throw new Error('Error getting schedule data:', error);
        }
      }

    static updateSession = async (sessionId, userId) => {
        try {
            const query1 = `UPDATE  therapy_session SET booking_status=true WHERE session_id=${sessionId}`;
            const query2 = `INSERT INTO  appointment (user_id, session_id, complete) VALUES (${userId},${sessionId}, 'false');`;
            console.log(query1);
            console.log(query2);
            await pool.cQuery(query1);
            await pool.cQuery(query2);
        } catch (error) {
            throw new Error('Error Finding Councillors:', error);
        }
    }

    static getUserDetail = async()=>{
        console.log("Dfdf")
        try{
            var activeresult =  await application_user.findAll({
                where:{
                    account_status:'inactive'
                }
            });

            var inactiveresult = await application_user.findAll({
                where:{
                    account_status:{
                        [Op.not] : 'inactive'
                    }
                }
            })
            return {
                actv_users:activeresult,
                inactv_users:inactiveresult
            }
        }
        catch(e){
            console.log(e)
        }
    }

}

module.exports = ApplicationUser;

