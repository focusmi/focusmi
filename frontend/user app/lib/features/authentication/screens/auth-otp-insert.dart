import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/authentication/services/auth_service.dart';
import 'package:focusmi/layouts/user-layout.dart';

class OTPinsert extends StatefulWidget {
  const OTPinsert({super.key});
  static const String routeName = '/auth-screen';

  @override
  State<OTPinsert> createState() => _OTPinsertState();
}

class _OTPinsertState extends State<OTPinsert> {
  late final TextEditingController number1;
  late final TextEditingController number2;
  late final TextEditingController number3;
  late final TextEditingController number4;

  String readOTP() {
    return number1.text + number2.text + number3.text + number4.text;
  }

  void sendNumber(context) {
    String val = readOTP();
    AuthService.authenticateOTP(otp: val, context: context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    number1 = TextEditingController();
    number2 = TextEditingController();
    number3 = TextEditingController();
    number4 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();
    return layout.mainLayout(Column(
      children: [
        Container(
          child: Row(children: [
            Container(
              width: 100,
              child: TextField(
                  controller: number1,
                  maxLength: 1,
                  decoration: InputDecoration(counterText: '')),
            ),
            Container(
              width: 100,
              child: TextField(
                  controller: number2,
                  maxLength: 1,
                  decoration: InputDecoration(counterText: '')),
            ),
            Container(
              width: 100,
              child: TextField(
                  controller: number3,
                  maxLength: 1,
                  decoration: InputDecoration(counterText: '')),
            ),
            Container(
              width: 100,
              child: TextField(
                  controller: number4,
                  maxLength: 1,
                  decoration: InputDecoration(counterText: '')),
            ),
          ]),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: GlobalVariables.primaryColor),
            onPressed: () {
              sendNumber(context);
            },
            child: Text(
              "Send OTP",
              style: TextStyle(color: Colors.white),
            ))
      ],
    ));
  }
}
