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
            const query = `SELECT * FROM public.administrative_user
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
            const query = `SELECT * FROM public.appointment WHERE user_id=${userId}`;
            const users = await pool.cQuery(query);
            return users;
        } catch (error) {
            throw new Error('Error Finding Councillors:', error);
        }
    }

    static listtimeslots = async (userId) => {
        try {

            const query = `SELECT * FROM public.therapy_session WHERE user_id=${userId} AND booking_status='false'`;
            const slot_list = await pool.cQuery(query);
            return slot_list;

        } catch (error) {

            throw new Error('Error Finding Councillors:', error);
        }
    }

    static updateSession = async (sessionId, userId) => {
        try {
            const query1 = `UPDATE public.therapy_session SET booking_status=true WHERE session_id=${sessionId}`;
            const query2 = `INSERT INTO public.appointment (user_id, session_id, complete) VALUES (${userId},${sessionId}, 'false');`;
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

