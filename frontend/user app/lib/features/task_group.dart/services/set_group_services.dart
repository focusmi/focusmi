import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focusmi/models/taskgroup.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:focusmi/constants/error_handling.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/constants/utils.dart';


class GroupService{

  void createGroup({
    required BuildContext context,
    required String group_name,
    required String status,
    required String member_count,
    required int group_id

  })async{
      TaskGroup group = TaskGroup(group_id: group_id,group_name: group_name, status: status, member_count:member_count,created_at: '');
      http.Response res = await http.post(Uri.parse('$uri/api/create-group'), body: group.toJson(), headers:<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      httpErrorHandle(response: res, context: context, onSuccess: ()async{
        showSnackBar(context, "Successful");
        SharedPreferences prefs =await SharedPreferences.getInstance();
        await prefs.setString('auth-token', (jsonDecode(res.body))['acccesstoken']);
        Provider.of<UserProvider>(context, listen:false).setUser(res.body);
      });
  }

  static Future getGroups()async{
      SharedPreferences prefs =await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token'); 
      http.Response groups = await http.get(Uri.parse('$uri/api/task-groups'), headers:<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization':'Bearer '+token.toString()
      });
     
      return groups;
  }

  static Future getGroupMember(groupID)async{
      SharedPreferences prefs =await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token'); 
      http.Response members = await http.get(Uri.parse('$uri/api/get-group-members/$groupID'), headers:<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization':'Bearer '+token.toString()
      });
      return members;
  }

    static Future addGroupMember(groupID,userID)async{
      SharedPreferences prefs =await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token'); 
      http.Response result = await http.get(Uri.parse('$uri/api/add-group-member/$userID/$groupID'), headers:<String, String>{

        'Content-Type': 'application/json; charset=UTF-8',
        'authorization':'Bearer '+token.toString()
      });
      print(result.body);
      return result;
  }

   static Future removeGroupMember(groupID,userID)async{
      SharedPreferences prefs =await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token'); 
      http.Response result = await http.get(Uri.parse('$uri/api/remove-group-member/$userID/$groupID'), headers:<String, String>{

        'Content-Type': 'application/json; charset=UTF-8',
        'authorization':'Bearer '+token.toString()
      });
      
      return result;
  }


}
