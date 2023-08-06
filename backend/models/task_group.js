const { get } = require("http");
const pool =  require("../database/dbconnection");
const { joinJson } = require("../JSON/JSON");
const {task_group} = require("../sequelize/models");
const {group_user} = require("../sequelize/models");

class TaskGroup{
    
    constructor(group_id, group_name, created_date, status,creator_id){
        this.group_id = group_id;
        this.group_name =  group_name;
        this.created_date =  created_date;
        this.status = status;
        this.creator_id = creator_id;   
    }

    async createGroup(){
        try{
            
            var res = pool.cQuery(`Insert into task_group (group_name,status,"creator_id") values('${this.group_name}','${this.status}',${this.creator_id}) RETURNING group_id`);
            var res = pool.cQuery(`Insert into group_user ("group_id","user_id",member_status) values('${res}','${this.creator_id}','administrator')`);
            return true;
        }
        catch {
            return false;
        }
        
    }



    async getTaskGroups(id){
        try{
            var res =await pool.cQuery(`select * from task_group where "creator_id"=${id} or "group_id" in (select "group_id" from group_user where "user_id"=${id} );`)
            var mem_count = await this.getGroupMemberCount(id);
            res = joinJson(res,mem_count,"group_id", "member_count","member_count");
            return res;
        }
        catch (e){
            return e;
        }
    }

    async getGroupMemberCount(id){
        try{
            var res =await pool.cQuery(`Select task_group."group_id",count(group_user."user_id")+1 as member_count from group_user full outer join task_group on task_group."group_id" = group_user."group_id" full outer join application_user on application_user."user_id" = group_user."user_id" where task_group."creator_id"=${id} or group_user."user_id"=${id} group by task_group."group_id" `)
            return res;
        }
        catch(e){
            return false

        }
    }

    async getGroupMembers(groupid,userid){
        try{
            console.log(`select * from group_user full outer join task_group on task_group."group_id" = group_user."group_id" full outer join application_user on application_user."user_id" = group_user."user_id" where group_user."group_id"=${groupid} and task_group."creator_id"<>${userid} `)
            var res =await pool.cQuery(`select * from group_user full outer join task_group on task_group."group_id" = group_user."group_id" full outer join application_user on application_user."user_id" = group_user."user_id" where group_user."group_id"=${groupid} and group_user."user_id"<>${userid} `)
            if(res==0){
                return {};
            }
            else{

                return res;
            }
        }
        catch(e){
            console.log(e)
            return false

        }
    }

    async addGroupUser(groupid,userid){
        console.log("reached")
        try{
            const d = new Date();
            var date=d.toISOString();
            pool.cQuery(`insert into group_user (user_id,group_id,created_at,updated_at) values(${userid},${groupid},'${date}','${date}')`)
            console.log("Added")

            return true;

        }
        catch(e){
            console.log(e)
            return false
        }
    }

    async removeGroupUser(groupid,userid){
        console.log("reached");
        try{
            await group_user.destroy({
                where:{
                    group_id:groupid,
                    user_id:userid
                }
            }) 
            return true;
        }
        catch(e){

        }
    }
    
}

module.exports = TaskGroup;