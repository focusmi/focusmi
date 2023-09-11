import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';

void showErrorSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: GlobalVariables.errorColor,
      content: Text(text),
      padding: EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      elevation:500,

    )
  );
}

void showSuccessSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: GlobalVariables.primaryColor,
      content: Text(text),
      padding: EdgeInsets.all(15),
      elevation:500,

    )
  );
}