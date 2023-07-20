import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/authentication/screens/auth_screen.dart';
import 'package:focusmi/features/authentication/screens/sigin_screen.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:focusmi/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers:[
    ChangeNotifierProvider(create:(context)=>UserProvider(),)
  ],child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'focusmi',
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (routeSettings) => generateRoute(routeSettings),
      home: const LandingPage(),
    );
  }
}

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
      
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}