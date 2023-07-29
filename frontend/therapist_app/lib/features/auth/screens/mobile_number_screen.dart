import 'package:flutter/material.dart';
import 'package:therapist_app/features/auth/screens/phone_verification_screen.dart';
import 'package:therapist_app/constants/global_variables.dart';
import '../../../common/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberInputPage extends StatefulWidget {
  @override
  State<PhoneNumberInputPage> createState() => _PhoneNumberInputPageState();
}

class _PhoneNumberInputPageState extends State<PhoneNumberInputPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'LK');
  bool _isPhoneNumberErrorVisible =
      false; // Track visibility of the error message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' '),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/images/Phone like.json',
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.width * 0.6,
                  ),
                  Text(
                    "Add phone number",
                    style: TextStyle(
                      color: GlobalVariables.greyTextColor,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'A 4-digit OTP will be sent via \n SMS to verify your number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: GlobalVariables.blackText,
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            _phoneNumber = number;
                            // Hide the error message when the user starts typing
                            _isPhoneNumberErrorVisible = false;
                          });
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.DROPDOWN,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: _phoneNumber,
                        formatInput: false,
                        maxLength: 9,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        cursorColor: Colors.black,
                        inputDecoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 15, left: 0),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.transparent,
                            fontSize: 0,
                          ),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 16),
                        ),
                        spaceBetweenSelectorAndTextField: 0,
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                        // Validate the phone number when the user moves to the next field
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid phone number';
                          }
                          if (!value.trim().contains(RegExp(r'^\d{9}$'))) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  // Display error message outside the container
                  Visibility(
                    visible: _isPhoneNumberErrorVisible,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        'Please enter a valid phone number',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  CustomButton(
                    text: "Proceed",
                    onTap: () {
                      // Show the error message immediately if there is a validation error
                      setState(() {
                        _isPhoneNumberErrorVisible =
                            !_formKey.currentState!.validate();
                      });

                      if (!_isPhoneNumberErrorVisible) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhoneVerificationScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
