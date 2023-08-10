import 'package:flutter/material.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/auth/screens/sign_in_page.dart';
import 'package:therapist_app/features/auth/screens/sign_up_page.dart';

enum AuthPage { signUp, signIn }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthPage _authPage = AuthPage.signUp;

  void toggleAuthPage() {
    setState(() {
      _authPage =
          _authPage == AuthPage.signUp ? AuthPage.signIn : AuthPage.signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;

    if (_authPage == AuthPage.signUp) {
      currentPage = SignInPage();
    } else {
      currentPage = SignInPage();
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 50),
                child: const Text(
                  'FocusMi',
                  style: TextStyle(
                    color: GlobalVariables.primaryText,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(child: currentPage),
              // Align(
              //   // Center the Row horizontally
              //   alignment: Alignment.center,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         _authPage == AuthPage.signUp
              //             ? 'Already have an account?'
              //             : 'Don\'t have an account?',
              //         style: const TextStyle(
              //           color: GlobalVariables.greyTextColor,
              //           fontSize: 16,
              //         ),
              //       ),
              //       TextButton(
              //         onPressed: toggleAuthPage,
              //         child: Text(
              //           _authPage == AuthPage.signUp ? 'Sign In' : 'Sign Up',
              //           style: const TextStyle(
              //             color: GlobalVariables.primaryText,
              //             fontSize: 16,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
