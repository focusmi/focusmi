import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/authentication/screens/sigin_screen.dart';
import 'package:focusmi/features/authentication/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:focusmi/features/authentication/widgets/textfield.dart';
import 'package:focusmi/layouts/user-layout.dart';
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
  Validators local_validator = new Validators();
  final FormTextField textField = FormTextField();

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
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

  void signUpUser() {
    authService.createUser(
        email: _email.text,
        password: _password.text,
        username: _username.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();
    return layout.mainLayout(
      SingleChildScrollView(
        child: Form(
          key: _form_key,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Container(
                    child: Column(
                  children: [
                    const Text(
                      'Keep the First Step',
                      style: TextStyle(fontSize: 25),
                    ),
                    const Text(
                      'FocusMi will guide you to the success',
                      style: TextStyle(fontSize: 15),
                    ),
                    Image.asset(
                      'assets/images/choose-task.gif',
                      height: 350,
                      width: 400,
                    ),
                  ],
                )),
                textField.createFormField(
                    _username,
                    "Enter Your Username",
                    false,
                    'Username',
                    r'^[A-Za-z][A-Za-z0-9_]{4,29}$',
                    'Please enter a correct username'),
                const SizedBox(height: 10),
                textField.createFormField(
                    _email,
                    "Enter Your Email",
                    false,
                    'Email',
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    'Please enter a correct Email'),
                const SizedBox(height: 10),
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
                      if (_form_key.currentState!.validate()) {
                        signUpUser();
                      }
                    },
                    child: const Text("Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
