import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
class CustomContainer{
  static Widget normalContainer(Widget widget, double height, double width ){
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