const pool = require("../database/dbconnection");
const {notification} = require("../sequelize/models");

class UserNotification{

    static async createNotifcation(noti_content){
        var noti = noti_content
        switch(noti_content.type){
            case 'invite':{
                console.log("here")
                var message = "You have been invited to join a task group"
                notification.create({
                    user_id:noti.user_id,
                    text:message,
                    type:"invite",
                    group_id:noti.group_id,
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
            var result = await pool.cQuery(`Select * from notification where noti_id in (Select max(noti_id) from notification where user_id=${userid} and status<>'inactive')`)
            return result
        }
        catch(e){

        }
    }

    static async getSettedTasks(user_id){
        try{
            var result =  await pool.cQuery(`Select * from task left join task_plan on task.plan_id=task_plan.plan_id where task_plan.user_id=${user_id};`)
            var ret =[]
            for (var element in result) {
                var  targetDate = `${result[element].reminder_date}`.split(" ")[0]
                var  targetTime = `${result[element].reminder_time}`
                var currentDate = (new Date()).toISOString().split('T')[0]
                var currentTime =(new Date()).toISOString().split('T')[1].split('.')[0].slice(0,5)
                if(targetDate == currentDate){
                    if(this.isCurrentTimeInRange(targetTime)){
                        ret.push(result[element])
                    }
                }

            }
            return ret
        }
        catch(e){
            console.log(e)

        }
    }
    static isCurrentTimeInRange(targetTime) {
        const currentTime = new Date();
        const targetTimeParts = targetTime.split(':');
        const targetHour = parseInt(targetTimeParts[0], 10);
        const targetMinute = parseInt(targetTimeParts[1], 10);
        const targetDateTime = new Date();
        console.log(targetHour)
        targetDateTime.setHours(targetHour);
        targetDateTime.setMinutes(targetMinute);
        targetDateTime.setSeconds(0);

        // Subtract 5 minutes from the target time
        console.log(currentTime)


        // Check if current time is after (or equal to) target time minus 5 minutes
        // and before target time
        if (currentTime <= targetDateTime && currentTime >= new Date(targetDateTime).setMinutes(targetDateTime.getMinutes() -60)) {
            return true;
        } else {
            return false;
        }
}

}
module.exports = UserNotification