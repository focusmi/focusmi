import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';

class CustomButton{
  static roundFlatButton(Widget valueWiget, int verticalpadding, int horizontalpadding,setState){
      return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.primaryColor
                ),
                onPressed: (){
                  setState;
                  }, 
                child:const Icon(Icons.add,color: Colors.white,)
                );
            }
}