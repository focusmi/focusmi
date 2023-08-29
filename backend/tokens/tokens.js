const { sign, verify } = require('jsonwebtoken')
let dotenv = require("dotenv");
const { json } = require('body-parser');

dotenv.config()

const createAccessToken = userID =>{  
    return sign({userID}, process.env.ACCESS_TOKEN_SECRET, {
        expiresIn: '420m',
    })
};

const createRefreshToken = userID =>{
    return sign({ userID }, process.env.REFRESH_TOKEN_SECRET, {
        expiresIn: '7d',
    })
}

const sendAccessToken = (res, req, accesstoken,user) => {
    user[0]['token']=accesstoken
    user[0]['msg']="Success"
    console.log(user);
    res.status(200).json(user)
}

const sendRefreshToken = (res, refreshtoken) => {
    res.cookie('refreshtoken', refreshtoken, {
        httpOnly: true,
        path: '/refresh_token',
    })
}

const isAuth = (req,res) => {
    const authorization = req.headers['authorization'];
    if(!authorization){
        return false;
    }
    const token = authorization.split(' ')[1];
    try{
        const {userID} = verify(token, process.env.ACCESS_TOKEN_SECRET);
        userID['token']='';
        var id = userID[0].user_id;
        if(userID!=0){
            return userID;
        }
        else{
            return false;
        }
    }
    catch(e){
        console.log(e);
        return false;
        
    }
}


module.exports ={
    createAccessToken,
    createRefreshToken,
    sendAccessToken,
    sendRefreshToken,
    isAuth
}