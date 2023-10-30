import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:focusmi/features/authentication/screens/auth-otp-insert.dart';
import 'package:focusmi/features/authentication/screens/auth_choic_screen.dart';
import 'package:focusmi/features/authentication/screens/packages_page.dart';
import 'package:focusmi/features/authentication/services/auth_service.dart';
import 'package:focusmi/features/mainpage/screens/main_page.dart';
import 'package:focusmi/features/pomodoro_timer/widgets/countdown_timer.dart';
import 'package:focusmi/features/task_group.dart/screens/group_list.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:focusmi/router.dart';
import 'package:provider/provider.dart';

void main() async{
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
  await AndroidAlarmManager.initialize();
   
  await AndroidAlarmManager.periodic(const Duration(minutes: 1), 0, (){
    final DateTime now = DateTime.now();
 
  print("[$now] Hello, world!");
  });
  
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
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const MainScreen()
          : const LandingPage(),
      // home: MyApp(),
    );
  }
}



