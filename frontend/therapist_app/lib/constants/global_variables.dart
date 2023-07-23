import 'package:flutter/material.dart';

String uri = 'http://192.168.8.174:3002';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const greyBackgroundCOlor = Color(0xffebecee);
  static const greyTextColor = Color.fromARGB(173, 94, 133, 106);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const primarySwatch = Color.fromARGB(255, 23, 195, 37);
  static const primaryText = Color(0xff83de70);
}
