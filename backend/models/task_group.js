const pool =  require("../databse/dbconnection");


class TaskGroup{
    
    constructor(group_ID, group_name, created_date, status,creator_ID){
        this.group_ID = group_ID;
        this.group_name =  group_name;
        this.created_date =  created_date;
        this.status = status;
        this.creator_ID = creator_ID;   
    }

    
}