import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/auth/screens/auth_screen.dart';
import 'package:therapist_app/features/auth/services/auth_service.dart';
import 'package:therapist_app/features/home/service/homeService.dart';
import 'package:therapist_app/provider/user_provider.dart';
import 'package:therapist_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/widgets/bottom_bar.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authService.getUserData(context);
    });
    WidgetsBinding.instance.addObserver(this);
    setStatus(true);
  }

  void setStatus(bool status) async {
    status
        ? HomeService.updateUserState(state: 'online', context: context)
        : HomeService.updateUserState(state: 'offline', context: context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus(true);
    } else {
      setStatus(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FocusMi',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.primaryText,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? NavBarRoots()
          : const AuthScreen(),
    );
  }
}
