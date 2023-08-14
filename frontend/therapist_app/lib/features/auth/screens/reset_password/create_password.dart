import 'package:flutter/material.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/common/widgets/custom_textfield.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/validation/form_validators.dart';// Import the FormValidators class

class CreatePasswordScreen extends StatefulWidget {
  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
             padding: EdgeInsets.all(screenSize.width * 0.05),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create Password",
                        style: TextStyle(
                          color: GlobalVariables.greyTextColor,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Create a new password for your account.\n The new password should be \n different from your last one.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: GlobalVariables.blackText,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obscureText: _obscurePassword,
                        validator: FormValidators.validatePassword,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: _obscureConfirmPassword,
                        validator: (value) => FormValidators.validateConfirmPassword(value, _passwordController.text),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: "Reset Password",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle password creation logic here
                            String password = _passwordController.text;
                            String confirmPassword = _confirmPasswordController.text;
          
                            if (password != confirmPassword) {
                              print("Passwords do not match.");
                            } else {
                              print("Password successfully created: $password");
                              // Navigate to the next screen or perform the desired action
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
