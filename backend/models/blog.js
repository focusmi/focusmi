const {blog} = require("../sequelize/models");

class Blog{
    constructor(user_id, title, subtitle, description){
        this.user_id = user_id;
        this.title = title;
        this.subtitle = subtitle;
        this.description = description
    }

    static async getAllBlogs(){
        try{
            var result = await blog.findAll({
                order:[
                    ['updated_at','DESC']
                ]
            })
            return result;
        }
        catch(e){
            console.log(e)
        }
    }

    static async createBlog(object){
        try{
            blog.create({
                user_id:object.user_id,
                title:object.title,
                subtitle:object.subtitle,
                description:object.description
            })
        }
        catch(e){
            console.log(e)
        }
    }
}

module.exports = Blog