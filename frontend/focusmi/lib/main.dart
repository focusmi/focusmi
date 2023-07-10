import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/authentication/screens/auth_screen.dart';
import 'package:focusmi/features/authentication/screens/sigin_screen.dart';
import 'package:focusmi/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'focusmi',
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (routeSettings) => generateRoute(routeSettings),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  static const String routeName = "./main";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: ()=>{
                Navigator.pushNamed(context, AuthScreen.routeName)
              }, 
              child: const Text("Sign Up")),
          ),
        
        Center(
            child: ElevatedButton(
              onPressed: ()=>{
                Navigator.pushNamed(context, SignScreen.routeName)
              }, 
              child: const Text("Sign In")),
          ),
        ],
      ),
    );
  }
}