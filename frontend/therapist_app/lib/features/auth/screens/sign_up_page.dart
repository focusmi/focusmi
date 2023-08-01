import 'dart:math';

import 'package:flutter/material.dart';
import 'package:therapist_app/features/auth/screens/email_verification_screen.dart';
import 'package:therapist_app/features/auth/services/auth_service.dart';
import 'package:therapist_app/common/widgets/custom_textfield.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/features/auth/services/email_sender.dart';
import 'package:therapist_app/validation/form_validators.dart';

import '../../../constants/global_variables.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() async {
    if (_signUpFormKey.currentState!.validate()) {
      // Perform user registration using authService
      // Send an email to the user
      try {
        // Generate a random 4-digit verification code
        final random = Random();
        final verificationCode = random.nextInt(9000) + 1000;

        // Send the email with the verification code
        await EmailSender.sendEmail(
          recipientEmail: _emailController.text.trim(),
          subject: 'Email Verification Code',
          body: 'Your verification code is: $verificationCode',
        );
        // Now you can use the verificationCode for further verification, such as comparing it with the user's input.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmailVerificationScreen(
              verificationCode: verificationCode,
              context: context,
              email: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text,
            ),
          ),
        );
      } catch (e) {
        // Handle any errors that occurred during sending the email
        print('Error sending email: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the device's screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(
              screenSize.width * 0.05), // Adjust padding based on screen width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: screenSize.height *
                      0.04), // Adjust spacing based on screen height
              Text(
                'Create your account',
                style: TextStyle(
                  color: GlobalVariables.greyTextColor,
                  fontSize: screenSize.width *
                      0.05, // Adjust font size based on screen width
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                  height: screenSize.height *
                      0.03), // Adjust spacing based on screen height
              Form(
                key: _signUpFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      validator: FormValidators.validateEmail,
                      trimEnabled: true,
                    ),
                    SizedBox(
                        height: screenSize.height *
                            0.02), // Adjust spacing based on screen height
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Full Name',
                      validator: FormValidators.validateFullName,
                      trimEnabled: false,
                    ),
                    SizedBox(
                        height: screenSize.height *
                            0.02), // Adjust spacing based on screen height
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: FormValidators.validatePassword,
                      trimEnabled: true,
                    ),
                    SizedBox(
                        height: screenSize.height *
                            0.02), // Adjust spacing based on screen height
                    CustomButton(
                      text: 'Proceed',
                      onTap: () {
                        if (_signUpFormKey.currentState!.validate()) {
                          signUpUser();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
