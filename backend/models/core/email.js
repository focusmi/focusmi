const dotenv = require("dotenv");
const nodemailer = require('nodemailer');

dotenv.config()
const MAIL_SETTINGS={
    service: 'gmail',
    auth: {
      user: process.env.MAIL_EMAIL,
      pass: process.env.MAIL_PASSWORD,
    },
  };
    
  const transporter = nodemailer.createTransport(MAIL_SETTINGS);
  
  module.exports.sendMail = async (email, text, subject) => {
    try {
      let info = await transporter.sendMail({
        from: MAIL_SETTINGS.auth.user,
        to: email, 
        subject: subject,
        html:text,
      });
      return info;
    } catch (error) {
      console.log(error);
      return false;
    }
  };

  // `
  //       <div
  //         class="container"
  //         style="max-width: 90%; margin: auto; padding-top: 20px"
  //       >
  //         <h2>Welcome to the club.</h2>
  //         <h4>You are officially In ✔</h4>
  //         <p style="margin-bottom: 30px;">Pleas enter the sign up OTP to get started</p>
  //         <h1 style="font-size: 40px; letter-spacing: 2px; text-align:center;">${otp}</h1>
  //    </div>
  //     `