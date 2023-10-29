import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/authentication/screens/change_password_auth.dart';
import 'package:focusmi/features/authentication/services/auth_service.dart';
import 'package:focusmi/features/authentication/widgets/textfield.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/widgets/texts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController _password = TextEditingController();
  late TextEditingController _repassword = TextEditingController();
  final FormTextField textField = FormTextField();
  final _form_key = GlobalKey<FormState>();
  final FormTextField txtField = FormTextField();
  @override
  void initState() {
    // TODO: implement initState
    _password = TextEditingController();
    _repassword = TextEditingController();
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
              CustomText.titleText("Change Password - Step 2"),
              SizedBox(height:50),
                textField.createFormField(
                      _password,
                      "Enter Your Password",
                      true,
                      'Password',
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      '''Password must contain 
      1.inimum 1 Upper case
      2.Minimum 1 lowercase
      3.Minimum 1 Numeric Number
      4.Minimum 1 Special Character
      5.Common Allow Character ( ! @ # \$ \& * ~ )
    '''),textField.createFormField(
                        _password,
                        "Enter Your Password",
                        true,
                        'Password',
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        '''Password must contain 
        1.inimum 1 Upper case
        2.Minimum 1 lowercase
        3.Minimum 1 Numeric Number
        4.Minimum 1 Special Character
        5.Common Allow Character ( ! @ # \$ \& * ~ )
    '''),
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
                    //if(_form_key.currentState!.validate()){
          
                    // }
                  },
                  child: const Text("Change Password")),
            ],
          ),
        ),
      ),
    ));
  }
}
