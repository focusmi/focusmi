const pool = require("../database/dbconnection");
const {hash, compare} = require("bcryptjs");

class authUser {

    constructor(email, password, username) {
      this.username = username;
      this.email = email;
      this.password = password;
      this.token = '',
      this.id = ''

    }

    //check user if exist
    async checkEmailExist(){
      const res =await pool.cquery(`Select * from application_user where email='${this.email}'`);
      if(res){
        return true;
      }
      else{
        return false;
      }
    }

    //create new user
    async createUser(){
      if(await this.checkEmailExist(this.email)){
        return 'exists';
      }
      else{
        try{
          const res =  pool.cquery(`Insert into application_user (user_name,email,password) values('${this.username}', '${this.email}', '${await hash(this.password, 10)}')`);
          return true;
        }
        catch{
          return false;
        }
      }

    }

    //check if the password is correct 
    async checkUser() {
     
      const res = await pool.cquery(`Select password from application_user where email='${this.email}'`);
      const id = await pool.cquery(`Select * from application_user where email='${this.email}'`);
      if(!res) return 'nouser'; 
      var result = await compare(this.password, res[0].password)
      if(result){
        return id[0].user_ID;
      }
      else{
        return 'password';
      }
    }
    
    //updaee web token field
    async createToken() {
      const res =  await pool.cquery(`update application_user set token='${this.token}' where email='${this.email}'`)
    }

    async createTokenByID(id) {
      const res =  await pool.cquery(`update application_user set token='${this.token}' where "user_ID"='${this.id}'`)
    }
    
    async getUserByID(id){
      const res= await pool.cquery(`select * from application_user where "user_ID"=${id}`)
      if(res==0) return false;
      else return true;
    }


    


  }

  module.exports = authUser;