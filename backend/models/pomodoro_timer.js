
const {timer} = require('../sequelize/models')

class PomodoroTimer{
    constructor(stopped_time, break_duration, total_duration,status,turns){
        this.stopped_time = stopped_time
        this.break_duration = break_duration
        this.total_duration = total_duration
        this.status = status
        this.turns = turns
    }

    static async createTimer(body){
        try{
           timer.create({
            stopped_time : body.stopped_time,
            break_duration:body.break_duration,
            total_duration:body.total_duration,
            status:body.status,
            turns:body.turns,
            user_id:body.user_id
           }) 
        }
        catch(e){
            console.log("Error - Create Timer")
        }
    }

    static async attrGetter(attr, user_id){
        try{
            var result =  await timer.findAll({
                where:{
                    user_id:user_id
                }
            })
            
            return result[0].dataValues[`${attr}`]
            
        }
        catch(e){
            console.log("Error- Attribute Getter")
            console.log(e)

        }
    }

    static async attrSetter(attr, value, user_id){
        try{
            switch(attr){
                case 'status':{
                    timer.update({status:value},{
                        where:{
                            user_id:user_id 
                        }
                    })
                }
                case 'total_duration':{
                    timer.update({total_duration:value},{
                        where:{
                            user_id:user_id 
                        }
                    })
                }
                case 'break_duration':{
                    timer.update({break_duration:value},{
                        where:{
                            user_id:user_id 
                        }
                    })
                }
                case 'turns':{
                    timer.update({turns:value},{
                        where:{
                            user_id:user_id 
                        }
                    })
                }
                case 'rturns':{
                    timer.update({rturns:value},{
                        where:{
                            user_id:user_id 
                        }
                    })
                }
            }
        }
        catch(e){
            console.log("Error in route -  timer attribute setter")
            console.log(e)
        }
    }
}

module.exports = PomodoroTimer