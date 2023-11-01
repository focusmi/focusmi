const {daily_tip} = require("../sequelize/models");

class DailyTip{


    static async getAllTips(){
        try{
            var result = await daily_tip.findAll({
                order:[
                    ['updated_at','DESC']
                ]
            })
            result = result.map(course => course.dataValues);
            return result;
        }
        catch(e){
            console.log(e)
        }
    }

    static async getTipsById(id){
        try{
            var result = await daily_tip.findAll({
                order:[
                    ['updated_at','DESC']
                ],
                where:{
                    tip_id:id
                }
            })
            result = result.map(course => course.dataValues);
            return result;
        }
        catch(e){
            console.log(e)
        }
    }

    static async getByTipsDay(sday){
        try{
            var result = await daily_tip.findAll({
                order:[
                    ['updated_at','DESC']
                ],
                where:{
                    day:sday
                }
            })
            result = result.map(course => course.dataValues);
            return result;
        }
        catch(e){
            console.log(e)
        }
    }

    static async createTip(object){
        try{
            var result=  await daily_tip.create({
                day:object.day,
                text:object.text,
                content_location:object.content_location,
            })

            return result.dataValues.tip_id;
        }
        catch(e){
            console.log(e)
        }
    }
}

module.exports = DailyTip