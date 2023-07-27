import 'package:flutter/material.dart';
import 'package:therapist_app/features/auth/screens/verify_screen.dart';
import 'package:therapist_app/features/auth/services/auth_service.dart';
import 'package:therapist_app/common/widgets/custom_textfield.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';

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

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
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
                'Create your account',
                style: TextStyle(
                  color: GlobalVariables.greyTextColor,
                  fontSize: screenSize.width * 0.05, // Adjust font size based on screen width
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenSize.height * 0.03), // Adjust spacing based on screen height
              Form(
                key: _signUpFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Full Name',
                    ),
                    SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(height: screenSize.height * 0.02), // Adjust spacing based on screen height
                    CustomButton(
                      text: 'Proceed',
                      onTap: () {
                        // if (_signUpFormKey.currentState!.validate()) {
                        //   signUpUser();
                        // }
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => EmailVerificationPage()),
                        );
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
