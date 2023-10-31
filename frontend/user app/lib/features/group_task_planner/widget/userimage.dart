import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/models/groupmembers.dart';

class UserImage {
  static Widget createUserImage(GroupMember? member) {
    String? firstName = ((member?.username)?.split(" ")[0])?[0];
    String? secondName = ((member?.username)?.split(" ")[1])?[0];
    return Container(
      child:(member?.profile_image!=null)? CircleAvatar(
              radius: 60, //radius of avatar
              backgroundColor: Colors.green, //color
              backgroundImage:NetworkImage('$uri/api/assets/image/user-profs/${member?.profile_image}'),
                              
            ):
            Container( 
              child:Center(
                child: Text((firstName??'')+(secondName??''),
                style: TextStyle(color: Colors.white,fontSize: 15),),
              ) ,
              height:200,
              width: 40,
              decoration: BoxDecoration(
                color: GlobalVariables.primaryColor,
                  borderRadius: BorderRadius.circular(300) 
                  
                  //more than 50% of width makes circle
              ),
)
    );
  }
}
