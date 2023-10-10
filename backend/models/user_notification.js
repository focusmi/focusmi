const pool = require("../database/dbconnection");
const {notification} = require("../sequelize/models");

class UserNotification{

    static async createNotifcation(noti_content){
        var noti = noti_content.body
        switch(noti_content.body.type){
            case 'task':{
                console.log("here")
                var message = "Task notification"
                notification.create({
                    user_id:noti.user_id,
                    text:message,
                    type:"task",
                    task_id:noti.task_id,
                    status:"active"
                })
                break
            }
            case 'payment':{
                var message = ""
                notification.create({
                    user_id:noti.user_id,
                    text:message,
                    type:"payment",
                    payment_id:noti.payment_id,
                    status:"active"
                })
                break
            }
            case 'group':{
                var message = ""
                notification.create({
                    user_id:noti.user_id,
                    text:message,
                    type:"group",
                    group_id:noti.group_id,
                    status:"active"
                })
                break
            }
        }
    }

    static async changeStatus(notiid,status){
        try{
            notification.update({
                status:status
            },{
                where:{
                    noti_id:notiid
                }
            }
            
            )
        }
        catch(e){
            console.log(e)
        }
    }

    static async getNotification(userid){
        try{
            console.log(`Select * from notification where noti_id in (Select max(noti_id) from notification where user_id=${userid} and status<>'inactive')`)
            var result = await pool.cQuery(`Select * from notification where noti_id in (Select max(noti_id) from notification where user_id=${userid} and status<>'showed')`)
            return result
        }
        catch(e){

        }
    }

}
module.exports = UserNotification