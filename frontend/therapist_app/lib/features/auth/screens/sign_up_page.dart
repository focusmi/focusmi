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
  bool isSendingEmail = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() async {
    if (_signUpFormKey.currentState!.validate()) {
      setState(() {
        isSendingEmail = true;
      });

      try {
        final random = Random();
        final verificationCode = random.nextInt(9000) + 1000;

        await EmailSender.sendEmail(
          recipientEmail: _emailController.text.trim(),
          subject: 'Email Verification Code',
          body: 'Your verification code is: $verificationCode',
        );

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
        print('Error sending email: $e');
      } finally {
        setState(() {
          isSendingEmail = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenSize.height * 0.04),
              Text(
                'Create your account',
                style: TextStyle(
                  color: GlobalVariables.greyTextColor,
                  fontSize: screenSize.width * 0.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              Form(
                key: _signUpFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      validator: FormValidators.validateEmail,
                      trimEnabled: true,
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Full Name',
                      validator: FormValidators.validateFullName,
                      trimEnabled: false,
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: FormValidators.validatePassword,
                      trimEnabled: true,
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    isSendingEmail
                        ? CircularProgressIndicator() // Show loading indicator
                        : CustomButton(
                            text: 'Proceed',
                            onTap: () {
                              if (!isSendingEmail &&
                                  _signUpFormKey.currentState!.validate()) {
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
