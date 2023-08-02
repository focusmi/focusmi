import 'package:flutter/material.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:lottie/lottie.dart';
import 'package:therapist_app/features/auth/screens/reset_password/email_verification_screen.dart';
import 'package:therapist_app/validation/form_validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/images/Otp.json',
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.width * 0.6,
                    // Adjust animation size based on screen width
                  ),
                  Text(
                    "Forgot Your Password?",
                    style: TextStyle(
                      color: GlobalVariables.greyTextColor,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Enter the email address you\n used when you joined and \n we will send you the instructions \n to reset your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: GlobalVariables.blackText,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // Add horizontal padding to the input field
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      validator: FormValidators.validateEmail,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: GlobalVariables.primaryText, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: GlobalVariables.primaryText, width: 2),
                        ),
                        hintText: 'Enter your Email',
                        hintStyle: TextStyle(
                            color: Colors.grey.shade500, fontSize: 16),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight
                              .bold, // Set the font weight of the error message text
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide
                              .none, // Set the border to none when there is an error
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: "Send Code",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle forgot password logic here
                        // For this example, let's just print the email
                        print('Reset Password for email: $_email');
                        // Navigate to the phone verification screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmailVerificationScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
