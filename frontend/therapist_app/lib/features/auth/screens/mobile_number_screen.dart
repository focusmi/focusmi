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
                    // Adjust animation size based on screen width
                  ),
                  Text(
                    "Add phone number",
                    style: TextStyle(
                      color: GlobalVariables.greyTextColor,
                      fontSize: MediaQuery.of(context).size.width * 0.05, // Adjust font size based on screen width
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'A 4-digit OTP will be sent via \n SMS to verify your number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: GlobalVariables.blackText,
                      fontSize: MediaQuery.of(context).size.width * 0.03, // Adjust font size based on screen width
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // Add horizontal padding to the input field
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.grey.withOpacity(0.1), // Set the background color here
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            _phoneNumber = number;
                          });
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: _phoneNumber, // Set the default country code here
                        formatInput: false,
                        maxLength: 9,
                        keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                        cursorColor: Colors.black,
                        inputDecoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 15, left: 0),
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                        ),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: "Proceed",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
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
