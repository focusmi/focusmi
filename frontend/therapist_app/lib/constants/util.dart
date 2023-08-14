import 'package:therapist_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.showSnackBar(
    SnackBar(
      backgroundColor: GlobalVariables.primaryText,
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      action: SnackBarAction(label: 'Dismiss',textColor: Colors.yellow, onPressed: (){

      }),
    ),
  );
}
