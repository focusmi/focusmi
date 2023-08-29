const otpGenerator = require('otp-generator');


OTP_CONFIG= {
  upperCaseAlphabets: true,
  specialChars: false,
}

module.exports.generateOTP = () => {
  const OTP = otpGenerator.generate(4, OTP_CONFIG);
  return OTP;
};

