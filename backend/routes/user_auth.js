let express = require('express')
const AuthUser = require('../models/authuser')
let authRoutes = express.Router()
const {createAccessToken ,createRefreshToken, sendRefreshToken, sendAccessToken, isAuth}= require('../tokens/tokens')
const { verify } = require('jsonwebtoken')
const {administrative_user} = require('../sequelize/models')

//signup routes
authRoutes.post('/api/signup', async (req,res,next)=>{
    console.log('hi')
    const {username, email, password} = req.body;
    let User = new AuthUser(email, password, username);
    var result = await User.createUser();
    if(result=='exists'){
        res.status(400);
        res.send({msg:`User ${email} exists`});
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


authRoutes.post('/api/admin-signin',async(req,res,next)=>{
    console.log('hi')
    const {email,password} = req.body.user;
    let User = new AuthUser(email, password, '');
    var result = await User.checkAdminUser();
    if(result=='nouser'){
        console.log("exist")
        res.status(400);
        res.send({msg:"Wrong Email or Password",type:1});
    }
    else if(result=='password'){
        console.log("pass")
        res.status(400).send({msg:"Wrong Email or Password",type:2})
    }
    else{
        result=[result.dataValues]
        //create refresh and access token
        const accessToken = createAccessToken(result)
        const refreshToken = createRefreshToken(result)
        User.id =  result
        User.token = refreshToken
        sendAccessToken(res, req, accessToken,result);
    }
    next(); 
})

authRoutes.post('/api/signin', async (req,res,next) => {
    console.log("inside")
    const {email,password} = req.body;
    let User = new AuthUser(email, password, '');
    var result = await User.checkUser();
    if(result=='nouser'){
        res.status(400);
        res.send({msg:"Wrong Email or Password",type:1});
    }
    else if(result=='password'){
        res.status(400).send({msg:"Wrong Email or Password",type:2})
    }
    else{
        //create refresh and access token
        const accessToken = createAccessToken(result)
        const refreshToken = createRefreshToken(result)
        User.id =  result
        User.token = refreshToken
        sendAccessToken(res, req, accessToken,result);
       

    }
    next(); 
})


authRoutes.get('/api/testuser',async(req,res,next) => {
    const userId=isAuth(req,res);
    if(userId!=null){
        console.log(userId);
    }
    next();
})

authRoutes.get("/api/is-token-valid",async(req, res, next)=>{
    try{
        const userID= isAuth(req, res);
        if(userID == false){
            res.status(400)
            res.json("");
        }
        else{
            res.status(200)
            res.json(userID);
        }
    }
    catch{
        res.json(false);
    }
    next();
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
    let user = new AuthUser();
    let result = user.getUserByID(payload.userId)
    if(result==0) res.send({accessToken:''})
    if(result.token !== token ) res.send({accessToken:''})
    const accessToken = createAccessToken(result.id)
    const refreshToken =createRefreshToken(result.id)
    user.id = result.user_id;
    user.token = result.refreshToken;
    user.createTokenByID(payload.userId)
    sendRefreshToken(res, refreshToken)
    return res.send({accessToken});

    
})


module.exports = authRoutes;