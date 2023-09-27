const { Op } = require("sequelize");
const pool =  require("../database/dbconnection");
const {sub_task} = require("../sequelize/models");
const user_task = require("../sequelize/models/user_task");


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
                task_id : body.task_id,
                sub_priority :body.sub_priority,
                sub_status : body.sub_status,
                sub_label:body.sub_label,
                sub_status:body.sub_status,
            })
        }
        catch(e){
            console.log(e)
        }
    }

    static async setSubTaskAttr(attribute, staskid, value){
         switch (attribute) {
            case 'sub_status':
                var result = await sub_task.update({sub_status:value},{
                    where:{
                        stask_id:staskid
                    }
                })
                break;
            case 'sub_priority':
                var result = await sub_task.update({sub_label:value},{
                    where:{
                        stask_id:staskid
                    }
                })
                break;
            default:
                break;
        }
    }

    static async allocateTaskUser(taskid, userid){
        try{
            var result =  await user_task.create({
                user_id:userid,
                task_id:taskid,

            })
        }
        catch(e){
            console.log("allocate task user")
            console.log(e)
        }
    }

    static async getAllocatedUsers(taskid){
        try{
            var result = await pool.cQuery(`Select * from user_task left join task on task.task_id=user_task.task_id where user_task.task_id = ${taskid}`);
            return result
        }
        catch(e){
            console.log(e)
        }
    }

    
  
   
}

module.exports = SubTask