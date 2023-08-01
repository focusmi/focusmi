import 'package:flutter/material.dart';
import 'package:therapist_app/constants/util.dart';
import 'package:therapist_app/features/auth/screens/mobile_number_screen.dart';
import 'package:therapist_app/features/auth/services/auth_service.dart';
import 'package:therapist_app/features/auth/widgets/verification_form.dart';



class EmailVerificationScreen extends StatefulWidget {
  final int verificationCode;
  final String email;
  final String password;
  final String name;

  EmailVerificationScreen({
    required this.verificationCode,
    required this.email,
    required this.password,
    required this.name,
    required BuildContext context,
  });

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: VerificationForm(
          verificationType: VerificationType.Email,
          onSubmit: (_otpController) {

            _verifyOTP(_otpController);
          },
          // 
        ),
      );
    }
  }

  void _verifyOTP(String code) {
    int userEnteredOTP = int.tryParse(code) ?? 0;
    if (userEnteredOTP == widget.verificationCode) {
      // The user-entered OTP is correct, you can return true or perform further actions
      print(widget.name);
      authService.signUpUser(
        context: context,
        email: widget.email, 
        password: widget
            .password, 
        name: widget.name, 
      );
      Navigator.pop(context, true);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhoneNumberInputPage(),
        ),
      );
    } else {
      // The user-entered OTP is incorrect, you can show an error message or handle it as needed
      showSnackBar(context, 'Incorrect OTP');
    }
  }
}
