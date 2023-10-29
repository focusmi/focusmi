import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/authentication/screens/change_password_auth%20copy.dart';
import 'package:focusmi/features/authentication/screens/change_password_auth.dart';
import 'package:focusmi/features/authentication/services/auth_service.dart';
import 'package:focusmi/features/authentication/widgets/textfield.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/widgets/texts.dart';

class ChangePasswordAuth extends StatefulWidget {
  const ChangePasswordAuth({super.key});

  @override
  State<ChangePasswordAuth> createState() => _ChangePasswordAuthState();
}

class _ChangePasswordAuthState extends State<ChangePasswordAuth> {
  late TextEditingController _email = TextEditingController();
  final FormTextField textField = FormTextField();
  final _form_key = GlobalKey<FormState>();
  final FormTextField txtField = FormTextField();
  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();

    return layout.mainLayout(Padding(
      padding: const EdgeInsets.all(14.0),
      child: Center(
        child: Form(
          key: _form_key,
          child: Column(
            
            children: [
              SizedBox(height: 250,),
              CustomText.titleText("Change Passwird - Step 1"),
              SizedBox(height:50),
              textField.createFormField(
                    _email,
                    "Enter Your Email",
                    false,
                    'Email',
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    'Please enter a correct Email'),
              const SizedBox(height: 25),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: GlobalVariables.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () async {
                    if(_form_key.currentState!.validate()){
                       Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => (ChangePassword())),
                            );
                    }
                  },
                  child: const Text("Change Password")),
            ],
          ),
        ),
      ),
    ));
  }
}
