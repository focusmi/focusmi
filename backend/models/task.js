const pool =  require("../database/dbconnection");
const {task} = require("../sequelize/models");


class Task{
    
    constructor(task_id, plan_id, timer_id, duration, task_status, priority, created_date, created_time, completed_date, completed_time, color, description){
        this.task_id = task_id;
        this.plan_id = plan_id;
        this.timer_id =  timer_id;
        this.duration = duration;
        this.task_status = task_status;
        this.priority = priority;
        this.created_date = created_date;
        this.created_time = created_time;
        this.completed_date = completed_date;
        this.completed_time = completed_time
        this.color = color;
        this.description = description;
    }

    
    /* **************************Task methods realted to individual task planner*********************** */
    static async createTask(taskOb){
        var result = await task.create({
            plan_id:taskOb.plan_id,
            task_name:taskOb.task_name,
            timer_id:taskOb.timer_id,
            duration:task.duration,
            task_status:task.task_status,
            priority: task.priority,
            description:task.description,
        })
        return result
    }

    static async getPlanTask(taskplan){
        var result = await task.findAll({
            where:{
                plan_id:taskplan
            }
        })
        return result
    }

    static async updateTask(taskid, attribute, value){
        switch (attribute) {
            case 'task_name':
                var result = await task.update({task_name:value},{
                    where:{
                        task_id:taskid
                    }
                })
                break;
            case 'color':
                var result = await task.update({color:value},{
                    where:{
                        task_id:taskid
                    }
                })
                break;
            case 'description':
                var result = await task.update({description:value},{
                    where:{
                        task_id:taskid
                    }
                })
                break;f
        
            default:
                break;
        }
    }

    
    /* **************************Task methods realted to group taks planner**************************** */
    
    
}

module.exports = Task