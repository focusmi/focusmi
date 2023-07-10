import "package:focusmi/features/authentication/screens/auth_screen.dart";
import "package:focusmi/features/authentication/screens/sigin_screen.dart";
import "package:focusmi/main.dart";
import "package:flutter/material.dart";

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder:(_) => const AuthScreen(),
      );
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder:(_) => const HomePage(),
      );
    case SignScreen.routeName:
    return MaterialPageRoute(
        settings: routeSettings,
        builder:(_) => const SignScreen(),
      );
    default:
    return MaterialPageRoute(
        settings: routeSettings,
        builder:(_) => const Scaffold(
          body: Text("Wrong Page !"),
        ),
      );

  }
}