
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

    static async attrGetter(attr, timer_id){
        try{
            var result =  await timer.findAll({
                where:{
                    timer_id:timer_id
                }
            })
            console.log(result)
            return result[0].dataValues[`${attr}`]
            
        }
        catch(e){
            console.log("Error- Attribute Getter")
            console.log(e)

        }
    }

    static async attrSetter(attr, value, timer_id){
        try{
            switch(attr){
                case 'status':{
                    timer.update({status:value},{
                        where:{
                            timer_id:timer_id 
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