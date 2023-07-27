import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/features/auth/screens/mobile_number_screen.dart';

import '../../../common/widgets/custom_profile_app_bar.dart';
import '../../../constants/global_variables.dart';

class EmailVerificationPage extends StatefulWidget {
  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomProfileAppBar(title: ''),
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
  final _formKey = GlobalKey<FormState>();
  List<String> _verificationCodes = ['', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Wrap the VerificationForm with SingleChildScrollView
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [Lottie.asset('assets/images/Mailing.json')],
            ),
            const SizedBox(height: 10),
            const Text("Verify it's you",
                style: TextStyle(
                  color: GlobalVariables.greyTextColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 15),
            const Text(
              'We send a one-time code \n to your email to confirm',
              textAlign: TextAlign.center,
              style: TextStyle(
              color: GlobalVariables.blackText,
              fontSize: 16,
              fontWeight: FontWeight.w300,
               ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < _verificationCodes.length; i++)
                  SizedBox(
                    width: 50,
                    height: 50,
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

                // if (_formKey.currentState!.validate()) {
                //   FocusScope.of(context).unfocus();
                //   widget.onSubmit(_verificationCodes.join());
                // }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneNumberInputPage(),
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

void main() {
  runApp(MaterialApp(
    home: EmailVerificationPage(),
  ));
}
