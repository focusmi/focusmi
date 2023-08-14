import 'package:flutter/material.dart';
import '../widgets/verification_form.dart';

class PhoneVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' '),
      ),
      body: VerificationForm(
        verificationType: VerificationType.Phone,
        onSubmit: (code) {
          // Add your phone verification logic here
          // For this example, let's just print the code
          print('Phone Verification Code: $code');
        },
      ),
    );
  }
}
