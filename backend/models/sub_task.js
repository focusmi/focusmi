const { Op } = require("sequelize");
const pool =  require("../database/dbconnection");
const {task} = require("../sequelize/models");
const sub_task = require("../sequelize/models/sub_task");


class SubTask{ 

    constructor(stack_id, task_id, sub_priority, sub_status){
       this.stack_id =  stack_id
       this.task_id = task_id 
       this.sub_priority = sub_priority
       this.sub_status = sub_status
    }

    static async createSubTask(body){
        try{
            sub_task.create({
                stack_id : body.stack_id,
                task_id : body.task_id,
                sub_priority :body.sub_priority,
                sub_status : body.sub_status
            })
        }
        catch(e){
            console.log(e)
        }
    }

    
  
   
}

module.exports = SubTask