import 'package:focusmi/features/authentication/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:focusmi/main.dart';

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
    return Scaffold(

      body: Column(
        children: [
          TextField(
            controller: _username,
            decoration: const InputDecoration(
              hintText: "Enter You Username"
            ),
          ),
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
              signUpUser();
          }
          
          , child: const Text("SingUp")
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