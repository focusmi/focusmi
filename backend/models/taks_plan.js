const pool = require("../database/dbconnection");
const {task_plan} = require("../sequelize/models");

class TaskPlan{

    constructor(plan_id, group_id, plan_names, location, schedule_type, schedule_date, time, reminder_status,schedule_time){
        this.plan_id = plan_id;
        this.group_id = group_id;
        this.plan_name= plan_names;
        this.location = location;
        this.schedule_type = schedule_type;
        this.schedule_date =schedule_date;
        this.schedule_time = schedule_time;
        this.time = time;
        this.reminder_status = reminder_status;
        
    }

    async getTaksPlans(user_id){
        var res=await pool.cQuery(`SELECT * FROM TASK_PLAN WHERE 'user_id'=${user_id}`);
        return res;
    }

    static async getTaskPlanByGroup(groupid){
        var res = await task_plan.findAll({
            order:[
                ["createdAt","ASc"]
            ],
            where:{
                group_id:groupid
            }
        })
        return res
    }

    async createTaskPlan(plan,userid){
        try{

            var res = await task_plan.create({
                group_id:plan.group_id,
                plan_name:plan.plan_name,
                location:plan.location,
                schedule_type:plan.schedule_type,
                scheduled_date:plan.schedule_date,
                schedule_time:plan.schedule_time,
                time:plan.time,
                remider_status:plan.remider_status,
                user_id:userid
    
            })
    
            return res;
        }
        catch(e){
            console.log(e)
            return false
        }
    }

    async renameTaskPlan(planid, name){
        try{
          await task_plan.update({plan_name:name},{
            where:{
                plan_id:planid
            }
          })
          return true
        }
        catch(e){
            console.log(e)
            return false;
        }
    }

    async deleteTaskPlan(planid){
        try{
            await task_plan.destroy({
                where:{
                    plan_id:planid
                }
            })
        }
        catch(e){
            console.log(e)
        }
        
    }

    // get recent task planner used by users
    // -by scheduled date, created date, newly created task plans 
    async getRecentTaskPlans(userId){
        var res = await pool.cQuery('select * from task left join task_plan on task_plan.plan_id=task.plan_id order by task_plan.updated_at;')
        return res;
    }

    




    
}

module.exports =TaskPlan