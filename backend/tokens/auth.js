const jwt =  require('jsonwebtoken');
const { isAuth } = require('./tokens');

const auth =  async (req, res, next) => {
    try{
        const result = await isAuth(req,res);
        if(result!=0){
            req.user = result;
           
        }
        else{
            return result;
        }
    
    }catch(err){
            return {};
    }
    next();
}

module.exports =  auth