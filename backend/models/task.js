const pool =  require("../databse/dbconnection");


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


    /* **************************Task methods realted to group taks planner**************************** */
}