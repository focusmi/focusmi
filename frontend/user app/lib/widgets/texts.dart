import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';

class CustomText {
  static Widget normalText(String text){
    return  Text(
      text,style: TextStyle(color: GlobalVariables.greyFontColor),);
  }

  static Widget titleText(String title){
    return Text(
      title,style: TextStyle(color: GlobalVariables.greyFontColor,fontSize: 22 ),);
  }

  static Widget buttonWhiteText(String text){
    return  Text(
      text,style: TextStyle(color:Colors.white),);
  }
  
} 