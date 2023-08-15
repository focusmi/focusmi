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

}

const AUser = {

    listCounciloors: async () => {
        try {
            const query = `SELECT * FROM public.administrative_user
            ORDER BY user_id ASC`;
            const users = await pool.cQuery(query);
            return users;
        } catch (error) {
            throw new Error('Error Finding Councillors:', error);
        }
    },

    listAppointments: async () => {
        try {
            const query = `SELECT * FROM public.appointment
            ORDER BY appointment_id ASC`;
            const users = await pool.cQuery(query);
            return users;
        } catch (error) {
            throw new Error('Error Finding Councillors:', error);
        }
    },

    listtimeslots: async (userId) => {
        try {
            const query = `SELECT * FROM public.therapy_session WHERE user_id=${userId} AND booking_status='false'`;
            console.log(query);
            const slot_list = await pool.cQuery(query);
            return slot_list;
        } catch (error) {
            throw new Error('Error Finding Councillors:', error);
        }
    },

    updateSession: async (sessionId,userId) => {
        try {
            const query1 = `UPDATE public.therapy_session SET booking_status=true WHERE session_id=${sessionId}`;
            const query2 = `INSERT INTO public.appointment (user_id, session_id, appointment_status) VALUES (${userId},${sessionId}, 'Not Completed');`;
            console.log(query1);
            console.log(query2);
            await pool.cQuery(query1);
            await pool.cQuery(query2);
        } catch (error) {
            throw new Error('Error Finding Councillors:', error);
        }
    }

}

module.exports = ApplicationUser;
module.exports = AUser;
