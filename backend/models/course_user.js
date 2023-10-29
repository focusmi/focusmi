const pool = require("../database/dbconnection");
const {mindfulness_course} = require("../sequelize/models");
const {course_user} = require("../sequelize/models");

class CourseUser{

    constructor(course_id,user_id,){
        this.course_id  = course_id;
        this.user_id = user_id
    }

    static allocateCourseUser(courseid, userid) {
        try{
            pool.cQuery(`insert into course_user (course_id, user_id) values('${courseid}','${userid}')`)
            // course_user.create({
            //     course_id:courseid,
            //     user_id:userid
            // })
        }
        catch(e){
            console.log("erro in course user")
        }
    }




    
    
    
}

module.exports = CourseUser;