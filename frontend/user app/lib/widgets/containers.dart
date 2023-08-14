import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
class CustomContainer{
  static normalContainer(Widget widget, double height, int width ){
    return  Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: GlobalVariables.textFieldBgColor,   
                 )
               ),
               child: widget,
            );
  }
}