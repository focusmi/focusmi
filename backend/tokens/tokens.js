const { sign, verify } = require('jsonwebtoken')
let dotenv = require("dotenv");

dotenv.config()

const createAccessToken = userID =>{  
    return sign({userID}, process.env.ACCESS_TOKEN_SECRET, {
        expiresIn: '15m',
    })
};

const createRefreshToken = userID =>{
    return sign({ userID }, process.env.REFRESH_TOKEN_SECRET, {
        expiresIn: '7d',
    })
}

const sendAccessToken = (res, req, accesstoken) => {
    res.status(200).send({
        'msg':"Success",
        'accesstoken':accesstoken,
        'email': req.body.email,
    })
}

const sendRefreshToken = (res, refreshtoken) => {
    res.cookie('refreshtoken', refreshtoken, {
        httpOnly: true,
        path: '/refresh_token',
    })
}

const isAuth = (req,res) => {
    const authorization = req.headers['authorization'];
    if(!authorization) res.status(400).send("You need to login");
    const token = authorization.split(' ')[1];
    try{
        const {userID} = verify(token, process.env.ACCESS_TOKEN_SECRET);
        return userID;
    }
    catch{
        return 0;
    }
}

module.exports ={
    createAccessToken,
    createRefreshToken,
    sendAccessToken,
    sendRefreshToken,
    isAuth
}