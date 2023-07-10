import 'package:flutter/material.dart';
import 'package:focusmi/features/authentication/services/auth_service.dart';
import 'package:focusmi/main.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});
  static const String routeName = '/sign_screen';
  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final AuthService authService = AuthService();
  
  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  void dispose(){
    _email = TextEditingController();
    _password = TextEditingController();
    super.dispose();
  }
  void userSignUp(){
    authService.signInUser(email: _email.text, password: _password.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration:const InputDecoration(
                hintText: "Enter Your Email"
            ),
          ),
          TextField(
            controller: _password,
            decoration:const InputDecoration(
                hintText: "Enter Your Password"
            ),
          ),
          ElevatedButton(
            onPressed: () async {
             Navigator.pushNamed(context, HomePage.routeName);
          }
          
          , child: const Text("Back")
          ),
        ],
      ),
    );
  }
}