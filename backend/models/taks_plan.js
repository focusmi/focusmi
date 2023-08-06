const pool = require("../database/dbconnection");

class TaskPlan{

    constructor(plan_id, group_id, plan_names, location, schedule_type, schedule_date, time, reminder_status, created_date){
        this.plan_id = plan_id;
        this.group_id = group_id;
        this.plan_names = plan_names;
        this.location = location;
        this.schedule_type = schedule_type;
        this.schedule_date =schedule_date;
        this.time = time;
        this.reminder_status = reminder_status;
        this.created_date = created_date;
    }

    async getTaksPlans(user_id){
        var res=await pool.cQuery(`SELECT * FROM TASK_PLAN WHERE 'user_id'=${user_id}`);
        return res;
    }
    
}