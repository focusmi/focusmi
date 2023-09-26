const { Op } = require("sequelize");
const pool =  require("../database/dbconnection");
const {sub_task} = require("../sequelize/models");


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

    
  
   
}

module.exports = SubTask