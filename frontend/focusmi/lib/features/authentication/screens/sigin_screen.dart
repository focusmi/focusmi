import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/authentication/services/auth_service.dart';
import 'package:focusmi/features/authentication/widgets/textfield.dart';
import 'package:focusmi/layouts/user-layout.dart';
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
    LayOut layout = new LayOut();
    return layout.FrostGlassBg(

      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            txtField.createFormField(_email,"Enter the Email",false),
            const SizedBox(height: 10),
            txtField.createFormField(_password,"Enter the Password",true),
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
    );
  }
}