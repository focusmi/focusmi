import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';

class FormTextField{
  Widget createFormField(controller, hinttext,ob){

    return  TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText:hinttext,
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:GlobalVariables.textFieldBgColor ),
                        borderRadius: BorderRadius.circular(20.0),
                      )
                  ),
                  obscureText: ob,
                  style: TextStyle(fontSize: 12 ,color:Colors.white),
                );
        }
}
