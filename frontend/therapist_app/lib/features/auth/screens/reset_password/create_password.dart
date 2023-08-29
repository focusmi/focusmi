import 'package:flutter/material.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/auth/screens/auth_screen.dart';
import 'package:therapist_app/features/auth/screens/reset_password/services/reset_pwd_service.dart';
import 'package:therapist_app/validation/form_validators.dart';

class CreatePasswordScreen extends StatefulWidget {
  final String email;
  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
  CreatePasswordScreen({required this.email});
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _errorText;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    // Validate the passwords.
    String? error =
        FormValidators.validateNewPasswords(password, confirmPassword);

    if (error != null) {
      // Set the error text for the respective fields.
      setState(() {
        _errorText = error;
      });
      return;
    }

    ResetPwdService.changePassword(
      context: context,
      password: password,
      email: widget.email,
    ).then((success) {
      if (success) {
        print('Password changed successfully');
         Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthScreen()
                  ),
                );
      } else {
        print('Failed to change password');
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          hintText: 'New Password',
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 16),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey.shade500,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText1 =
                                    !_obscureText1; // Toggle the value of _obscureText
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureText2,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          hintText: 'Confirm Password',
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 16),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorText: _errorText,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey.shade500,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText2 =
                                    !_obscureText2; // Toggle the value of _obscureText
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      CustomButton(
                        text: "Reset Password",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _changePassword();
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
