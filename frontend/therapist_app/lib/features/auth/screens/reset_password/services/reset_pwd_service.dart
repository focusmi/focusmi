import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/constants/util.dart';
import 'package:therapist_app/features/auth/screens/email_verification_screen.dart';
import 'package:therapist_app/features/auth/services/email_sender.dart';

class ResetPwdService {
  static Future<void> findEmail({
    required BuildContext context,
    required String email,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/apis/forgot-password-email-verify'),
        body: jsonEncode({"email": email}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      void sendEmail(verificationCode, updatedValue) async {
        await EmailSender.sendEmail(
          recipientEmail: updatedValue.trim(),
          subject: 'Email Verification Code',
          body: 'Your verification code is: $verificationCode',
        );
      }

      if (res.statusCode == 200) {
        final random = Random();
        final verificationCode = random.nextInt(9000) + 1000;
        sendEmail(verificationCode, email);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResetPwdEmailVerificationScreen(
              verificationCode: verificationCode,
              context: context,
              email: email,
            ),
          ),
        );
      } else {
        showSnackBar(context, 'can not find the email');
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  static Future<bool> changePassword({
    required BuildContext context,
    required String password,
    required String email,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$uri/apis/reset-password'),
        body: jsonEncode({
          'password': password,
          'email': email,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        final errorBody = jsonDecode(response.body);
        final errorMessage = errorBody['error'] ?? 'Failed to reset password';
        showSnackBar(context, errorMessage);
        return false;
      }
    } catch (error) {
      print('Error changing password: $error');
      return false;
    }
  }
}
