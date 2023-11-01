const pool = require("../database/dbconnection")
const {chat} = require("../sequelize/models")
const {user_chat} = require("../sequelize/models")

class UserChat{
    constructor(user_id,chat_id,message_text, message_type, image){
        this.user_id = user_id
        this.chat_id = chat_id
        this.message_text = message_text
        this.message_type = message_type
        this.image = image
    }

    static async createChat(groupid){
        try{
            chat.create({
                group_id:groupid
            })
        }
        catch(e){
            console.log("Error in the create chat")
            console.log(e)
        }
    }

    static async addMessage(chat,user,message){
        console.log(chat+"-"+user)
    
        try{
            user_chat.create({
                user_id:user,
                chat_id:chat,
                message_text:message,
                message_type:"text",
                image:""
            })
        }
        catch(e){
            console.log(e)
            console.log("Error in the add message")
        }
    }

    static async getChatByGroup(groupid){
        try{
            var result = await chat.findOne({
                where:{
                    group_id:groupid
                }
            })
            return result.dataValues.chat_id
        }
        catch(e){
            console.log("Error in get chat by group")
            console.log(e)
        }
    }

    static async getChatMessage(groupid){
        try{
            var chat_id = await this.getChatByGroup(groupid)
            var result  = await pool.cQuery(`Select * from user_chat where chat_id=${chat_id}`)
            return result;
        }
        catch(e){
            console.log(e)
        }
    }

    
}

module.exports = UserChat