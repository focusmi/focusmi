import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';

class MainPageCatTile {
  static greenPageTile(String text, double width) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(255, 108, 182, 93)
      ),
      width: width,
      height: 60,
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(text,style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),
        ],
      ),
    );
  }

    static greenPageTileSubTask(Widget widget, double width) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:  Color.fromARGB(255, 108, 182, 93)
      ),
      width: width,
      height: 70,
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget
          ),
        ],
      ),
    );
  }
}
