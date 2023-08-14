import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String IP =  dotenv.get("IP", fallback:"");

String uri = 'http://'+IP +':3001';

class GlobalVariables {
  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const greyBackgroundColor = Color(0xffebecee);
  static const greyTextColor = Color.fromARGB(173, 94, 133, 106);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const primarySwatch = Color.fromARGB(255, 23, 195, 37);
  static const primaryText = Color.fromRGBO(131, 222, 112, 1);
  static const blackText = Colors.black;
}
