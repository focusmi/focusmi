import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/authentication/services/auth_service.dart';
import 'package:focusmi/features/authentication/widgets/textfield.dart';
import 'package:focusmi/layouts/user-layout.dart';

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
  final FormTextField txtField = FormTextField();
  
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
    authService.signInUser(context:context,email:_email.text, password: _password.text);
  }
  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();
    return layout.mainLayout(

      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Container(
                 child:Column(
                      children: [
                        const Text(
                          'Hi, Welcome Back',
                          style:TextStyle(fontSize: 25),
                        ),
                       
                        Image.asset(
                      'assets/images/choose-task.gif',
                      height: 350,
                      width: 400,
                    ),
                      ],
                    )
              ),
              txtField.createFormField(_email,"Enter the Email",false,'email','',''),
              const SizedBox(height: 10),
              txtField.createFormField(_password,"Enter the Password",true,'password','',''),
              const SizedBox(height: 25),
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
                  userSignUp();
              }
              
              , child: const Text("Sign In")
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}