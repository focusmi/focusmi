import 'package:therapist_app/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/common/widgets/custom_textfield.dart';

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
    return SingleChildScrollView(
      // Wrap with SingleChildScrollView
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Login to your account',
              style: TextStyle(
                color: GlobalVariables.greyTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 25),
            Form(
              key: _signInFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                children: [
                  CustomTextField(
                    controller: _emailController,
                    hinText: 'Email',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    hinText: 'Password',
                  ),
                  const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            TextButton(
                onPressed: (){},
                child: const Text(
                      'Have yor forgotten yor password ?',
                  style: TextStyle(
                    color: GlobalVariables.greyTextColor,
                    fontSize: 16,
                  ),
                ),
             ),
          ],
        ),
      ),
    );
  }
}
