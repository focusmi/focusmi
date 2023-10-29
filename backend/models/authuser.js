const pool = require("../database/dbconnection");
const {hash, compare} = require("bcryptjs");
const {application_user} = require('../sequelize/models');
const {administrative_user} = require("../sequelize/models");
const {user_otp} = require("../sequelize/models");
const { generateOTP } = require("./core/otp");
const { sendMail } = require("./core/email");
const { createAccessToken, sendAccessToken } = require("../tokens/tokens");
const timer = require("../sequelize/models/timer");


class AuthUser {

    constructor(email, password, username) {
      this.username = username;
      this.email = email;
      this.password = password;
      this.id = '';

    }

    //check user if exist
    async checkEmailExist(){
      const res = await pool.cQuery(`Select * from application_user where email='${this.email}' and account_status<>'not verfied'`);
      if(res){
        return true;
      }
      else{
        return false;
      }
    }

    //create new user
    //if new user is not verifed and need to signup againg delete already existing account
    async createUser(res,req){
      if(await this.checkEmailExist(this.email)){
        return 'exists';
      }
      else{
        try{
          this.password=await hash(this.password, 10);
          var user = await application_user.findOne({where:{email:this.email}})
          if(user){
            user_otp.destroy({
              where:{
                user_id:user.user_id
              }
            }
  
            )
            timer.destroy(
              {
                where:{
                  email:this.email,
                  account_status:"not verfied"
                }
              }
            )
            application_user.destroy(
              {
                where:{
                  user_id:user.dataValues.user_id
                }
              }
            )

          }
         user =await application_user.create({
            username:this.username,
            email:this.email,
            password:this.password,
            account_status:"not verfied"
         })
        

         timer.create({
          stopped_time:'',
          break_duration:5,
          total_duration:20,
          status:'not-in-use',
          turns:1,
          user_id:user.dataValues.user_id

         })

         //generate OTP
          let otp = generateOTP();
          user_otp.create({
            user_id:user.dataValues.user_id,
            otp:otp
          })
          sendMail(this.email, otp)
          const accessToken = createAccessToken([user.dataValues])
          
          sendAccessToken(res, req, accessToken,[user.dataValues]);
          return true;
        }
        catch(e){
          console.log(e)
          return false;
        }
      }

    }

    //check if the password is correct 
    async checkUser() {
      const res = await pool.cQuery(`Select password from application_user where email='${this.email}'`);
      const id = await pool.cQuery(`Select * from application_user where email='${this.email}'`);
      if(!res) return 'nouser'; 
      var result = await compare(this.password, res[0].password)
      if(result){
        return id;
      }
      else{
        return 'password';
      }
    }
    
    async checkAdminUser() {
      // const res = await pool.cQuery(`Select password from application_user where email='${this.email}'`);
      const res = await administrative_user.findOne({where:{role:'admin',email:this.email}})

      // const id = await pool.cQuery(`Select * from application_user where email='${this.email}'`);
      if(res == null) return 'nouser'; 
      var result = await compare(this.password, res.password)
      if(result){
        return res;
      }
      else{
        return 'password';
      }
    }
    
    static async changePassword(password,userId) {
      try{
        let enc_password=await hash(password, 10);
        const res = await application_user.update({password:enc_password},{
          where:{
            user_id:userId
          }
        })
      }
      catch(e){
        console.log(e);
      }
    }
    
    static async sendOtp(userId){

    }

    //updaee web token field
    async createToken() {
      const res =  await pool.cQuery(`update application_user set token='${this.token}' where email='${this.email}'`)
    }

    async createTokenByID(id) {
      const res =  await pool.cQuery(`update application_user set token='${this.token}' where "user_id"='${this.id}'`)
    }
    
    async getUserByID(id){
      const res= await pool.cQuery(`select * from application_user where "user_id"=${id}`)
      if(res==0) return false;
      else return true;
    }

    static async changePackage(id, packageno){
      switch(packageno){
        case 1:{
          application_user.update({user_id:id},{
            where:{
              account_status:"no package"
            }
          })
          break
        }
        case 2:{
          application_user.update({user_id:id},{
            where:{
              account_status:"freedom"
            }
          })
          break
        }
        case 1:{
          application_user.update({user_id:id},{
            where:{
              account_status:"extra freedom"
            }
          })
          break
        }
      }
    }

    

    


  }

  module.exports = AuthUser;