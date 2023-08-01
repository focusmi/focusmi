import 'package:flutter/material.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:lottie/lottie.dart';

class VerificationForm extends StatefulWidget {
  final VerificationType verificationType;
  final void Function(String) onSubmit;

  VerificationForm({
    required this.verificationType,
    required this.onSubmit,
  });

  @override
  _VerificationFormState createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  List<String> _verificationCodes = ['', '', '', ''];
  String _errorMessage = ''; // Define the error message variable here

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenSize.width * 0.6,
              height: screenSize.width * 0.6,
              child: Lottie.asset(
                widget.verificationType == VerificationType.Email
                    ? 'assets/images/animation_lkl9la4o.json'
                    : 'assets/images/phone_otp.json',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.verificationType == VerificationType.Email
                  ? "Verify it's you"
                  : "Verify your phone number",
              style: TextStyle(
                color: GlobalVariables.greyTextColor,
                fontSize: screenSize.width * 0.05,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.verificationType == VerificationType.Email
                  ? 'We send a one-time code \n to your email to confirm'
                  : 'We send a one-time code \n to your phone to confirm',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: GlobalVariables.blackText,
                fontSize: screenSize.width * 0.03,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < _verificationCodes.length; i++)
                  SizedBox(
                    width: screenSize.width * 0.15,
                    height: screenSize.width * 0.15,
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
                          }
                        }
                        setState(() {
                          _verificationCodes[i] = value;
                          _errorMessage = ''; // Clear the error message on any input change
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
              text: (widget.verificationType == VerificationType.Email)
                  ? "Verify Email"
                  : "Verify Phone Number",
              onTap: () {
                if (_verificationCodes.any((code) => code.isEmpty)) {
                  setState(() {
                    _errorMessage =
                        "Please enter all the verification code digits.";
                  });
                } else {
                  setState(() {
                    _errorMessage = ''; // Clear the error message if the code is valid.
                  });

                  if (widget.verificationType == VerificationType.Email) {
                    widget.onSubmit(_verificationCodes.join());
                  } else {
                    // Add the logic to proceed with phone verification
                  }
                }
              },
            ),
            const SizedBox(height: 16),
            if (_errorMessage.isNotEmpty) // Show the error message if it's not empty
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

enum VerificationType {
  Email,
  Phone,
}
