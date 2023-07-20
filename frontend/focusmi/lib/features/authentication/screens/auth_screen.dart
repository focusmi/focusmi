import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/authentication/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:focusmi/features/authentication/widgets/textfield.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/main.dart';
import 'package:focusmi/validators.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth_screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;
  final AuthService authService = AuthService();
  final _form_key = GlobalKey<FormState>();
  Validators  local_validator =  new Validators();
  final FormTextField textField = FormTextField();

  @override
  void initState() {
    // TODO: implement initState
    _email =  TextEditingController();
    _password =  TextEditingController();
    _username = TextEditingController();
    super.initState();
  }  
 
 @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    _username.dispose();
    super.dispose();
  }
  void signUpUser(){
    authService.createUser(email: _email.text,password: _password.text,username: _username.text );
  }
  @override
  Widget build(BuildContext context) {
    LayOut layout = new LayOut();
    return layout.mainLayout(
      Form(
        key:_form_key,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              textField.createFormField(_username, "Enter Your Username", false),
              const SizedBox(height: 10),
              textField.createFormField(_email, "Enter Your Emaio", false),
              const SizedBox(height: 10),
              textField.createFormField(_password, "Enter Your Password", true),
              const SizedBox(
                height: 25
              ),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                foregroundColor:Colors.white ,
                backgroundColor: GlobalVariables.primaryColor,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
                minimumSize: const Size.fromHeight(50), // NEW
            ),
                onPressed: () async {
                  signUpUser();
              }
              
              , child: const Text("Sign Up")
              )
            ],
          ),
        ),
      ),
    );
  }
}