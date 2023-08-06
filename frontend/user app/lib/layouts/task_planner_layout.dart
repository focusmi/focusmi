import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';


class TaskPlannerLayout{
  static Widget mainBoard(Widget widget,navigationbar,appBarName){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              appBarName,
              style: const TextStyle(
                color:Colors.white
              ),
            )
          ],
        ),
        backgroundColor: GlobalVariables.primaryColor,
      ),
      body:widget,
      bottomNavigationBar: navigationbar,
    );
  }
}