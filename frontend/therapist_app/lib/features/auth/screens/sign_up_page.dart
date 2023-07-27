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
      name: _nameController.text
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Wrap with SingleChildScrollView
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
              const Text('Create your account',
              style: TextStyle(
              color: GlobalVariables.greyTextColor,
              fontSize: 26,
              fontWeight: FontWeight.w500,
               ),
              ),
              const SizedBox(height: 25),
            Form(
              key: _signUpFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                children: [
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Full Name',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true, 
                  ),
                  const SizedBox(height: 16),
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
    );
  }
}
