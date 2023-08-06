const { Op } = require("sequelize");
const pool = require("../database/dbconnection");
const {application_user} = require("../sequelize/models");


class ApplicationUser {

    constructor(email, password, username) {
      this.username = username;
      this.email = email;
      this.password = password;
      this.id = '';

    }

    async getUser(searchname,userid){
        var result =await application_user.findAll({
            where:{
                email:{[Op.like]:`%${searchname}%`},
                user_id:{[Op.not]:userid}
            }
        })
        return result
    }

    
    


  }

  module.exports = ApplicationUser;