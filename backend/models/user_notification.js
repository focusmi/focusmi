const {notification} = require("../sequelize/models");

class UserNotification{

    static async createNotifcation(noti_content){
        var noti = noti_content.body
        switch(noti_content.body.type){
            case 'task':{
                var message = ""
                notification.create({
                    user_id:noti.user_id,
                    text:message,
                    type:task,
                    task_id:noti.task_id,
                })
            }
            case 'payment':{
                var message = ""
                notification.create({
                    user_id:noti.user_id,
                    text:message,
                    type:payment,
                    payment_id:noti.payment_id,
                })
            }
            case 'group':{
                var message = ""
                notification.create({
                    user_id:noti.user_id,
                    text:message,
                    type:group,
                    group_id:noti.group_id,
                })
            }
        }
    }

}