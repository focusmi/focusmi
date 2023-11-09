import 'package:therapist_app/features/auth/screens/reset_password/fogot_password_screen.dart';
import 'package:therapist_app/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/common/widgets/custom_textfield.dart';
import 'package:therapist_app/validation/form_validators.dart';

import '../../../constants/global_variables.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the device's screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenSize.width * 0.05), // Adjust padding based on screen width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenSize.height * 0.04), // Adjust spacing based on screen height
              Text(
                'Login to your account',
                style: TextStyle(
                  color: GlobalVariables.greyTextColor,
                  fontSize: screenSize.width * 0.05, // Adjust font size based on screen width
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenSize.height * 0.03), // Adjust spacing based on screen height
              Form(
                key: _signInFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      validator: FormValidators.validateEmptyEmail,
                    ),
                    SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: FormValidators.validateEmptyPassword,
                    ),
                    SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
                    CustomButton(
                      text: 'Sign In',
                      onTap: () {
                        if (_signInFormKey.currentState!.validate()) {
                          signInUser();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
              TextButton(
                onPressed: () {
                   Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                        );
                },
                child: const Text(
                  'Have you forgotten your password?',
                  style: TextStyle(
                    color: GlobalVariables.greyTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16, // Adjust font size based on screen width
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
