import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/auth/screens/reset_password/create_password.dart';
// ... (imports and other code) ...

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: VerificationForm(
        onSubmit: (code) {
          // Add your verification logic here
          // For this example, let's just print the code
          print('Verification code: $code');
        },
      ),
    );
  }
}

class VerificationForm extends StatefulWidget {
  final void Function(String) onSubmit;

  VerificationForm({required this.onSubmit});

  @override
  _VerificationFormState createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  List<String> _verificationCodes = ['', '', '', ''];

  @override
  Widget build(BuildContext context) {
    // Get the device's screen size
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      // Wrap the VerificationForm with SingleChildScrollView
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // Wrap the Lottie animation with a Container
              width: screenSize.width * 0.6, // Set the width based on screen width
              height: screenSize.width * 0.6, // Set the height based on screen width
              child: Lottie.asset('assets/images/animation_lkl9la4o.json'),
            ),
            const SizedBox(height: 10),
            Text(
              "Verify it's you",
              style: TextStyle(
                color: GlobalVariables.greyTextColor,
                fontSize: screenSize.width * 0.05, // Adjust font size based on screen width
                fontWeight: FontWeight.w500, 
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'We send a one-time code \n to your email to confirm',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: GlobalVariables.blackText,
                fontSize: screenSize.width * 0.03, // Adjust font size based on screen width
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < _verificationCodes.length; i++)
                  SizedBox(
                    width: screenSize.width * 0.15, // Adjust width based on screen width
                    height: screenSize.width * 0.15, // Adjust height based on screen width
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (i < _verificationCodes.length - 1) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).unfocus();
                            widget.onSubmit(_verificationCodes.join());
                          }
                        }
                        setState(() {
                          _verificationCodes[i] = value;
                        });
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: GlobalVariables.primaryText,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: GlobalVariables.primaryText,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: "Proceed",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePasswordScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16), // Add some spacing at the bottom
          ],
        ),
      ),
    );
  }
}

