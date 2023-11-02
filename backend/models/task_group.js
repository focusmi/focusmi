const { get } = require("http");
const pool =  require("../database/dbconnection");
const { joinJson } = require("../JSON/JSON");
const {task_group,application_user} = require("../sequelize/models");
const {group_user} = require("../sequelize/models");
const { json } = require("sequelize");
const { sendMail } = require("./core/email");
const UserNotification = require("./user_notification");
const UserChat = require("./user_chat");

class TaskGroup{
    
    constructor(group_id, group_name,status,creator_id,member_count){
        this.group_id = group_id;
        this.group_name =  group_name;
        this.status = status;
        this.creator_id = creator_id;
        this.member_count = member_count

    }

    async createGroup(result){
        try{ 
            
            const d = new Date();
            var date=d.toISOString();
            

            // var res = pool.cQuery(`Insert into task_group (group_name,status,"creator_id") values('${this.group_name}','${this.status}',${this.creator_id}) RETURNING group_id`);
            // var res = pool.cQuery(`Insert into group_user ("group_id","user_id",member_status) values('${res}','${this.creator_id}','administrator')`);
            var group =await task_group.create({
                creator_id:result.group.creator_id,
                group_name:result.group.group_name,
                description:result.group.description,
                status:"Active",
            });
            UserChat.createChat(group.dataValues.group_id)
            pool.cQuery(`Insert into group_user ("group_id","user_id","previlage",created_at,updated_at) values(${group.dataValues.group_id},${result.group.creator_id},'member','${date}','${date}')`)
            var i=0;
          
            for(i;i<result.members.length;i++){
                var val = result.members[i]
                UserNotification.createNotifcation({
                    "user_id":val['user_id'],
                    "group_id":group.dataValues.group_id,
                    "type":"invite"
                });
                pool.cQuery(`Insert into group_user ("group_id","user_id","previlage",created_at,updated_at) values(${group.dataValues.group_id},${val['user_id']},'nonmember','${date}','${date}')`)
            };
            return true;
        }
        catch (e){
            console.log(e)
            return false;
        }
        
    }

    static async  editGroupUser(group_id, user_id ,status){
        try{
            pool.cQuery(`update group_user set previlage='${status}' where user_id=${user_id} and group_id=${group_id}`)
        }
        catch(e){
            console.log(e)
            
        }
    }



    async getTaskGroups(id){
        try{
            var res =await pool.cQuery(`select * from task_group where "creator_id"=${id} or "group_id" in (select "group_id" from group_user where "user_id"=${id} and previlage<>'nonmember');`)
            var mem_count = await this.getGroupMemberCount(id);
            res = joinJson(res,mem_count,"group_id", "member_count","member_count");
            return res;
        }
        catch (e){
            return e;
        }
    }

    async getChatBygroup(id){
        try{
            var result =await pool.cQuery(`select chat_id from chat where group_id=${id}`)
            return result
        }
        catch(e){

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
        try{
            var result =await application_user.findOne({
                user_id:userid
            })
            var email = result.dataValues.email
            const d = new Date();
            var date=d.toISOString();
            pool.cQuery(`insert into group_user (user_id,group_id,created_at,updated_at,previlage) values(${userid},${groupid},'${date}','${date}','nonmember')`)
            UserNotification.createNotifcation({
                    "user_id":userid,
                    "group_id":groupid,
                    "type":"invite"
                });
            sendMail(email,`
            <div>
                <h1>Group Member Invitation</h1>
            </div>
            `, "Focusmi group member invitation");

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