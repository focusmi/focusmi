// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:focusmi/constants/error_handling.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/constants/utils.dart';
import 'package:focusmi/models/groupmembers.dart';
import 'package:focusmi/models/taskgroup.dart';
import 'package:focusmi/providers/user_provider.dart';

class GroupService{

  static void createGroup({
    required BuildContext context,
    required String group_name,
    required String status,
    required String description,
    required int member_count,
    required int group_id,
    required List<GroupMember> members

  })async{
      
      TaskGroup group = TaskGroup(group_id: group_id,description: description,group_name: group_name, status: status, member_count:member_count.toString(),created_at: '',creator_id: Provider.of<UserProvider>(context,listen: false).user.user_id);
      group_info groupInfo = new group_info(group: group, members: members);
      http.Response res = await http.post(Uri.parse('$uri/api/create-group'), body:groupInfo.toJson(), headers:<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      print("reachedd");
      
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

 
  static Future  getGroupMemberByTaskID(taskID)async{
      SharedPreferences prefs =await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token'); 
      http.Response members = await http.get(Uri.parse('$uri/api/get-group-members-by-task/$taskID'), headers:<String, String>{
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

class group_info {
     TaskGroup group;
     List<GroupMember> members;
      group_info({
        required this.group,
        required this.members,
      });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'group': group.toMap(),
      'members': members.map((x) => x.toMap()).toList(),
    };
  }

  factory group_info.fromMap(Map<String, dynamic> map) {
    return group_info(
      group: TaskGroup.fromMap(map['group'] as Map<String,dynamic>),
      members: List<GroupMember>.from((map['member'] as List<int>).map<GroupMember>((x) => GroupMember.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory group_info.fromJson(String source) => group_info.fromMap(json.decode(source) as Map<String, dynamic>);
}
