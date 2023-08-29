const pool = require("../database/dbconnection");
const {hash, compare} = require("bcryptjs");
const {application_user} = require('../sequelize/models');
const {administrative_user} = require("../sequelize/models");
const {user_otp} = require("../sequelize/models");
const { generateOTP } = require("./core/otp");
const { sendMail } = require("./core/email");
const { createAccessToken, sendAccessToken } = require("../tokens/tokens");


class AuthUser {

    constructor(email, password, username) {
      this.username = username;
      this.email = email;
      this.password = password;
      this.id = '';

    }

    //check user if exist
    async checkEmailExist(){
      const res = await pool.cQuery(`Select * from application_user where email='${this.email}'`);
      if(res){
        return true;
      }
      else{
        return false;
      }
    }

    //create new user
    async createUser(res,req){
      if(await this.checkEmailExist(this.email)){
        return 'exists';
      }
      else{
        try{
          this.password=await hash(this.password, 10);
         let user =await application_user.create({
            username:this.username,
            email:this.email,
            password:this.password,
            account_status:"not verfied"
         })
         //generate OTP
          let otp = generateOTP();
          console.log("-------"+user.dataValues.user_id)
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

    

    


  }

  module.exports = AuthUser;