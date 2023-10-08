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

    static async addMessage(message){
        try{
            user_chat.create({
                user_id:message.user_id,
                chat_id:message.chat_id,
                message_text:message.message_text,
                message_type:message.message_type,
                image:message.image
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
            var result  = user_chat.findAll({
                where:{
                    chat_id:chat_id
                }
            })
            return result.dataValues
        }
        catch(e){
            console.log(e)
        }
    }

    static async createChatMessage(){

    }
}