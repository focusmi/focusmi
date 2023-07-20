import "package:focusmi/features/authentication/screens/auth_screen.dart";
import "package:focusmi/features/authentication/screens/sigin_screen.dart";
import "package:focusmi/features/mainpage/screens/main_page.dart";
import "package:focusmi/main.dart";
import "package:flutter/material.dart";

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder:(_) => const AuthScreen(),
      );
    case MainScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder:(_) => const MainScreen(),
      );
     case LandingPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder:(_) => const MainScreen(),
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