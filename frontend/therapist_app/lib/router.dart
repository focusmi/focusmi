import 'package:therapist_app/features/auth/screens/auth_screen.dart';
import 'package:therapist_app/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'common/widgets/bottom_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {

  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case NavBarRoots.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => NavBarRoots());
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(child: Text('Screen does not exist')),
              ));
  }
}
