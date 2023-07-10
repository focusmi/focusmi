let express = require('express')
const authUser = require('../models/authuser')
let authRoutes = express.Router()
const {createAccessToken ,createRefreshToken, sendRefreshToken, sendAccessToken, isAuth}= require('../tokens/tokens')
const { verify } = require('jsonwebtoken')

//signup routes
authRoutes.post('/api/signup', async (req,res,next)=>{
    const {username, email, password} = req.body;
    let User = new authUser(email, password, username);
    var result = await User.createUser();
    if(result=='exists'){
        res.status(400);
        res.send("User exists");
    }
    else if(result==false){
        res.status(400);
        res.send("Database connection error");
    }
    else{
        res.status(200);
        res.send("Account successfully created");
    }
    next();
})



authRoutes.post('/api/signin', async (req,res,next) => {
    const {email,password} = req.body;
    let User = new authUser(email, password, '');
    var result = await User.checkUser();
    if(result=='nouser'){
        res.status(400);
        res.send("User does not exists");
    }
    else if(result=='password'){
        res.status(400).send("Wrong password")
    }
    else{
        //create refresh and access token
        const accessToken = createAccessToken(result)
        const refreshToken = createRefreshToken(result)
        User.id =  result
        User.token = refreshToken
        //save token in the database
        User.createToken();
        sendRefreshToken(res, refreshToken);
        sendAccessToken(res, req, accessToken);

    }
    next(); 
})


authRoutes.get('/api/testuser',async(req,res,next) => {
    const userId=isAuth(req,res);
    if(userId!=null){
        console.log(userId);
    }

})


authRoutes.get('/refresh-token', (req,res) =>{
    const token =req.cookies.refreshToken;

    //if refresh token is not sent send empty access toekn
    if(!token) res.send({accessToken:''});

    let payload = null;
    try{
        payload = verify(token ,process.env.REFRESH_TOKEN_SECRET)
    } catch(err) {
        return res.send({accesstoken: ''});
    }
    //check if user exist
    let user = new authUser();
    let result = user.getUserByID(payload.userId)
    if(result==0) res.send({accessToken:''})
    if(result.token !== token ) res.send({accessToken:''})
    const accessToken = createAccessToken(result.id)
    const refreshToken =createRefreshToken(result.id)
    user.id = result.user_ID;
    user.token = result.refreshToken;
    user.createTokenByID(payload.userId)
    sendRefreshToken(res, refreshToken)
    return res.send({accessToken});

    
})


module.exports = authRoutes;