
/*--------------------------main api page---------------------------------*/
//libraries
let express= require("express")
let app = express();
let cookieParser = require('cookie-parser');
let path = require("path");
let cors = require("cors");
let bodyParser = require('body-parser');
let dotenv = require("dotenv");
let  {verify} = require('jsonwebtoken');
const dbmodel = require("../models/core/dbmodel");
const authRoutes = require("../routes/user_auth");
const authRouterTherapist = require("../routes/therapist_auth")
const ScheduleRouter = require('../routes/schedule')
const pool = require("../database/dbconnection");
const gTaskRoutes = require("../routes/group_task_planner");
const {task_group} = require("../sequelize/models");
const assetRouter = require("../routes/asset_routes");
const appointmentRouter = require("../routes/appointment"); 

dotenv.config()

/* ************
/**middleware********* */
//cookie handlding
app.use(cookieParser());


app.use(cors())
app.use(express.json())
app.use(express.urlencoded({extended: true}))//url encoded bodies)
app.use(bodyParser.json())
app.use(express.static('public'))

//all routes
app.use(assetRouter)
app.use(authRoutes)
app.use(gTaskRoutes)
app.use(authRouterTherapist)
app.use(ScheduleRouter)




const PORT = process.env.PORT || 3000

//connection
try{
    app.listen(PORT,() => console.info(`Server has started on ${PORT}`))

}
catch{
    console.log("Server failed");
}
