const { Pool } = require("pg");
const {sequelize} = require('../../sequelize/models');
const dotenv = require("dotenv");
dotenv.config();
class DbModel{
    constructor(pool=null){
        this.pool=pool;
    }
    connect = async()=>{
        try {
            this.pool = new Pool({
                user: process.env.PGUSER,
                host: process.env.PGHOST,
                database: process.env.PGDATABASE,
                password: process.env.PGPASSWORD,
                port: process.env.PGPORT,
            });
            await this.pool.connect();
            return this.pool;
            
        } catch (error) {
            console.log(error)
            return null;
        }
    }
   
    cQuery = async (query) => {
        let result = await this.pool.query(query);
        if(result.rowCount!=0) return (result.rows);
        else if(result.rowCount==0) return 0;
        
    
    }

}

module.exports = DbModel;