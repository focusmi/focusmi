// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/task_group.dart/services/set_group_services.dart';
import 'package:focusmi/features/task_group.dart/services/user_services.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/groupmembers.dart';

import 'package:focusmi/models/taskgroup.dart';

class EditTaskGroup extends StatefulWidget {
  static const String routeName = '/edit-task-group';
  final TaskGroup group;
  
  EditTaskGroup({
    Key? key,
    required this.group,
  }) : super(key: key);
  @override
  State<EditTaskGroup> createState() => _EditTaskGroupState();
}


class _EditTaskGroupState extends State<EditTaskGroup> {
  late final TextEditingController _searchvalue;
  List<GroupMember> memberList= List<GroupMember>.empty();
  List<GroupMember> searchMemberList = List<GroupMember>.empty();


  void getMembersFromApi(groupID) async{
    GroupService.getGroupMember(groupID).then((response){
      setState(() {
        try{
          Iterable list =json.decode(response.body).cast<Map<String, dynamic>>();
          memberList = list.map((model)=>GroupMember.fromJson(model)).toList();
        }
        catch(e){
          print("erro---------------");
          print(e);
          memberList = List.empty();
        }
      });
    });

  }
  
  void removeMemberApi(groupid, userid)async{
    try{
      var member = await GroupService.removeGroupMember(groupid, userid);
      getMembersFromApi(groupid);
    }
    catch(e){
      print(e);
    }
  }
      
  Future searchMemberApi()async{
      var members =await UserService.getUser(_searchvalue.text);
      setState(() {
        try{
          Iterable list =json.decode(members.body).cast<Map<String, dynamic>>();
          searchMemberList = list.map((model)=>GroupMember.fromJson(model)).toList();
         }
        catch(e){
          print("erro---------------");
          print(e);
          searchMemberList = List.empty();
        }
      });        

  }

  Future addMemberApi(userID)async{
   
    try{
      GroupService.addGroupMember(widget.group.group_id, userID);
      getMembersFromApi(widget.group.group_id);
    }
    catch(e){
      print(e);
    }
  }

  Widget _buildPopupDialog(BuildContext context,userid) {
    return AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            ElevatedButton(
              onPressed:(){
                removeMemberApi(widget.group.group_id, userid);
              }, 
              child: Text("Remove")
            )
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }


  var layout = LayOut();
  @override
  void initState() {
    super.initState();
    _searchvalue = TextEditingController();
    getMembersFromApi(widget.group.group_id);
  }
  @override
  Widget build(BuildContext context) {
    return layout.mainLayoutWithDrawer(context,
      
      SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.group.group_name),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:50.0),
              child: Container(
                height: 200,
                child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: memberList.length,
                      scrollDirection:Axis.horizontal,
                      itemBuilder: (context, index){
                        return Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(),
                            child: Row(
                              children: [
                                Container(
                                  height:50,
                                  child: Image.network('$uri/api/assets/image/user-profs/team.png'),
                                ),
                                Column(
                                  children: [
                                    Text(memberList[index].username),
                                    ElevatedButton(
                                      onPressed: (){
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) => _buildPopupDialog(context,memberList[index].user_id),
                                          );
                                      }, 
                                      child: Text("Edit")
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  child: TextField(
                    controller: _searchvalue,
                  ),
                  width:MediaQuery.of(context).size.width*0.70 ,
                ),
                SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  child:Text("Search"),
                  onPressed:()async{
                    searchMemberApi();
                  } , )
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: searchMemberList.length,
              itemBuilder: (context, index){
                return Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(),
                    child: Column(
                      children: [
                        FloatingActionButton(
                          child:Text("Add") ,
                          onPressed:()async{
                            addMemberApi(searchMemberList[index].user_id);
                          }
                        ),
                        Text(searchMemberList[index].username),
                        Container(
                          child: Image.network('$uri/api/assets/image/user-profs/team.png'),
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      )
     ,"Edit Task Group");
  }
}