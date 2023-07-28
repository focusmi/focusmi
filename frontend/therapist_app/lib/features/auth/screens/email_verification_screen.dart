import 'package:flutter/material.dart';
import '../widgets/verification_form.dart';

class EmailVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: VerificationForm(
        verificationType: VerificationType.Email,
        onSubmit: (code) {
          // Add your email verification logic here
          // For this example, let's just print the code
          print('Email Verification Code: $code');
        },
      ),
    );
  }
}
