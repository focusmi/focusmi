let customerModel = require("../models/customer.model");
let express = require('express');
let appointmentRouter = express.Router();

//cusomer route hadnling

router.post('/customer',(req,res)=>{
    if(!req.body){
        return res.status(400).send.apply("Request body is missing")
    }

    let model = new customerModel(req.body)
    model.save();
})

module.exports = appointmentRouterRouter;