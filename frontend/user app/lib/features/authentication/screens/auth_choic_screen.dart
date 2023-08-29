import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/authentication/screens/auth_screen.dart';
import 'package:focusmi/features/authentication/screens/sigin_screen.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = "./main";
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Row(
          children: [
             SizedBox(
              width: 10,
            ),
            Text(
              'FocusMi',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: GlobalVariables.primaryColor, //<-- SEE HERE
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(
                    'assets/images/team.jpg',
                    height: 400,
                    width: 400,
                  ),
              Center(
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.primaryColor,
                  minimumSize: const Size.fromHeight(50), // NEW
              ),
                  onPressed: ()=>{
                    Navigator.pushNamed(context, AuthScreen.routeName)
                  }, 
                  child: const Text(
                    "Sign Up",
      
                    style:TextStyle(color:Colors.white) ,
                    )),
              ),
            const SizedBox(height: 10),
            Center(
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.primaryColor,
                  minimumSize: const Size.fromHeight(50), // NEW
              ),
                  onPressed: ()=>{
                    Navigator.pushNamed(context, SignScreen.routeName)
                  }, 
                  child: const Text(
                    "Sign In",
                     style:TextStyle(color:Colors.white) , 
                  )),
              ),
            const SizedBox(height: 15),
            Container(
              child:const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "By signing up, you agree to out Terms of service and",
                    style:TextStyle(fontSize: 13),
                    
                  ),
                  Text(
                    "and Privacy Policy",
                    style:TextStyle(fontSize: 13),
                  )
                ],
              )
            )
            ],
          ),
        ),
      ),
    );
  }
}