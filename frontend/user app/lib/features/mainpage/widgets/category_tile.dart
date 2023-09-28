import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';

class MainPageCatTile {
  static greenPageTile(String text, double width) {
    return Container(
      width: width*1.2,
      height: 70,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(),
            SizedBox(),
            Text(text,style: TextStyle(
              color: GlobalVariables.primaryColor
            ),)
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: GlobalVariables.primaryColor,
            width: 2
            )),
    );
  }
}
