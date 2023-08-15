import 'package:flutter/material.dart';
import 'package:focusmi/features/authentication/screens/auth_choic_screen.dart';
import 'package:focusmi/features/authentication/services/auth_service.dart';
import 'package:focusmi/features/task_group.dart/screens/group_list.dart';
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
  final authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUser(context: context);
   
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
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty ?const GroupList():const LandingPage(),
    );
  }
}

