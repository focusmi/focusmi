import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/validators.dart';

class FormTextField{
  Widget createFormField(controller, hinttext,ob,label,regex,message){

    return  TextFormField(
      
                  controller: controller,
                  decoration: InputDecoration(
                      hintText:hinttext,
                      hintStyle:const TextStyle(color:Color.fromARGB(255, 161, 161, 161) ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:const BorderSide(color:GlobalVariables.textFieldBgColor ),
                        borderRadius: BorderRadius.circular(20.0)
                      )
                  ),
                  obscureText: ob,
                  style:const TextStyle(fontSize: 13 ,color:Color.fromARGB(255, 161, 161, 161) ),
                validator:(value) {
                    Validators  valid= Validators();
                    if(valid.checkNull(value)){
                      return "Please enter the $label";
                    }
                    else{
                      if(label!='' && valid.checkRegex(value, regex)){
                        return null;
                      }
                      else{
                        return message;
                      }

                    }
                }
                );


                }
        }

