import 'package:flutter/material.dart';
import 'package:therapist_app/features/auth/screens/verify_screen.dart';
import 'package:therapist_app/constants/global_variables.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_profile_app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomProfileAppBar(title: ''),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/images/animation_lkl9la4o.json',
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.6,
                  // Adjust animation size based on screen width
                ),
                Text(
              "Add phone number",
              style: TextStyle(
                color: GlobalVariables.greyTextColor,
                fontSize:MediaQuery.of(context).size.width * 0.05, // Adjust font size based on screen width
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'A 4-digit OPT will be send via \n SMS to verify your number',
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
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      // Handle phone number input changes
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    initialValue: PhoneNumber(isoCode: 'US'),
                    formatInput: true,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    inputDecoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: "Proceed",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmailVerificationPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
