const {mindfulness_course} = require("../sequelize/models");

class MindfulnessCourse{

    constructor(course_id,title, description, skill, duration, ratings, image){
        this.course_id  = course_id;
        this.title = title;
        this.description = description;
        this.skill = skill;
        this.duration = duration;
        this.ratings = ratings;
        this.image = image;
    }

    static async getAllCourses(){
        try{
            
        }
        catch(e){
            console.log("---------Get all courses-----------")
            console.log(e)
        }

    }

    
    
    
}