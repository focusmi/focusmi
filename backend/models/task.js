const { Op } = require("sequelize");
const pool =  require("../database/dbconnection");
const {user_task,task} = require("../sequelize/models");


class Task{
    
    constructor(task_id, plan_id, timer_id, duration, task_status, priority, created_date, created_time, completed_date, completed_time, color, description,deadline_date,deadline_time, location){
        this.task_id = task_id;
        this.plan_id = plan_id;
        this.timer_id =  timer_id;
        this.duration = duration;
        this.task_status = task_status;
        this.task_type=task_type;
        this.priority = priority;
        this.created_date = created_date;
        this.deadline_date=deadline_date;
        this.deadline_time = deadline_time;
        this.created_time = created_time;
        this.completed_date = completed_date;
        this.completed_time = completed_time
        this.color = color;
        this.description = description;
        this.location = location
    }

    
    /* **************************Task methods realted to individual task planner*********************** */
    static async createTask(taskOb){

        try{
            var result = await task.create({
                plan_id:taskOb.plan_id,
                task_name:taskOb.task_name,
                duration:task.duration,
                task_status:'pending',
                priority: task.priority,
                description:task.description,
                color:'nocolor',
                task_type:task.task_type,
                location:task.location
                
                
            })
            return result
        }
        catch(e){
            console.log(e)
        }
       
    }

    static async addColor(taskid,color){
        var result = await task.update(
            {color:color},
            {
                where:{
                    task_id:taskid
                }
            }
        )
    }

    static async getPlanTask(taskplan){
 
        var result = await task.findAll({
            where:{
                plan_id:taskplan,
                task_status:{
                    [Op.not]:'completed'
                }
            }
        })
        return result
    }
    static async getPlanTaskByUser(taskplan,user){
 
        var result = await pool.cQuery(`Select * from user_task left join task on task.task_id=user_task.task_id where task.plan_id=${taskplan} and user_task.user_id=${user}`)
        console.log(result)
        return result
    }

    static async getPlanTaskByUser(taskplan,user){
 
        var result = await pool.cQuery(`Select * from user_task left join task on task.task_id=user_task.task_id where task.plan_id=${taskplan} and user_task.user_id=${user} and task.group_id IS NOT NULL`)
        console.log(result)
        return result
    }

    static async getiPlanTaskByUser(user){
 
        var result = await pool.cQuery(`Select * from task_plan where user_id=${user} and group_id IS NULL`)
        console.log(result)
        return result
    }

    static async getCompletedGroupTasks(){
        var result = await task.findAll({
            where:{
                task_status:'completed',
                task_type:'group'
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
                break; 
        
            default:
                break;
        }
    }
    static async setAttribute(type,taskid,val){
        console.log(`${type}-${taskid}-${val}`)
        try{
       
            if(type == 'status'){
                task.update({task_status:val},{
                    where:{
                        task_id:taskid
                    }
                })
            }
            else if(type == 'color'){
                console.log(taskid)
                task.update({color:val},{
                    where:{
                        task_id:taskid
                    }
                })
            }
            else if(type == 'task_type'){
           
                task.update({task_type:val},{
                    where:{
                        task_id:taskid
                    }
                })
            }
            else if(type == 'task_name'){
           
                task.update({task_name:val},{
                    where:{
                        task_id:taskid
                    }
                })
            }
            else if(type == 'deadline_date'){
           
                task.update({deadline_date:val},{
                    where:{
                        task_id:taskid
                    }
                })
            }
            else if(type == 'deadline_time'){
           
                task.update({deadline_time:val},{
                    where:{
                        task_id:taskid
                    }
                })
            }
            else if(type == 'description'){
                task.update({description:val},{
                    where:{
                        task_id:taskid
                    }
                })
            }
            else if(type == 'plan_id'){
                console.log("dffdf");
                task.update({plan_id:val},{
                    where:{
                        task_id:taskid
                    }
                })
            }
             else if(type == 'reminder_date'){
                task.update({reminder_date:val},{
                    where:{
                        task_id:taskid
                    }
                })
            }
             else if(type == 'reminder_time'){
                
                task.update({reminder_time:val},{
                    where:{
                        task_id:taskid
                    }
                })
            }
            else if(type == 'location'){
                 
                pool.cQuery(`update task set location='${val}' where task_id=${taskid} `)
            }
        }
        catch(e){
            console.log(e)
        }
    }

    static async allocateTaskUser(taskid, userid){
        try{
            pool.cQuery(`insert into user_task (user_id, task_id) values(${userid},${taskid})`)
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
  
    /* **************************Task methods realted to group taks planner**************************** */
    
    
}

module.exports = Task