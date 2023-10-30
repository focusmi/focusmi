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
  late List<int> listInt= List<int>.empty(growable: true);

  void emptySearchList(){
      setState(() {
        searchMemberList=List<GroupMember>.empty();
      });

  }

  void getMembersFromApi(groupID) async{
    GroupService.getGroupMember(groupID).then((response){
      setState(() {
        try{
          Iterable list =json.decode(response.body).cast<Map<String, dynamic>>();
          memberList = list.map((model)=>GroupMember.fromJson(model)).toList();
          for(var element in memberList){
            listInt.add(element.user_id);
          }
         
         
        }
        catch(e){
          memberList = List.empty();
        }
      });
    });

  }
  

  void removeMemberApi(groupid, userid)async{
    try{
      var member = await GroupService.removeGroupMember(groupid, userid);
      GroupService.getGroupMember(groupid).then((response){
      setState(() {
        try{
          Iterable list =json.decode(response.body).cast<Map<String, dynamic>>();
          memberList = list.map((model)=>GroupMember.fromJson(model)).toList();
          for(var element in memberList){
            listInt.add(element.user_id);
          }
         
         
        }
        catch(e){
          memberList = List.empty();
        }
      });
    });
      setState(() {
        listInt.remove(userid);
      });
    }
    catch(e){
      print(e);
    }
    emptySearchList();
  }
      
  Future searchMemberApi()async{
      var members =await UserService.getUser(_searchvalue.text);
      setState(() {
        try{
          Iterable list =json.decode(members.body).cast<Map<String, dynamic>>();
          searchMemberList = list.map((model)=>GroupMember.fromJson(model)).toList();
         }
        catch(e){
          print(e);
          searchMemberList = List.empty();
        }
      });        

  }

  Future addMemberApi(userID)async{
   
    try{
      GroupService.addGroupMember(widget.group.group_id, userID);
      GroupService.getGroupMember(widget.group.group_id).then((response){
      setState(() {
        try{
          Iterable list =json.decode(response.body).cast<Map<String, dynamic>>();
          memberList = list.map((model)=>GroupMember.fromJson(model)).toList();
          for(var element in memberList){
            listInt.add(element.user_id);
          }
         
         
        }
        catch(e){
          memberList = List.empty();
        }
      });
    });
      listInt.add(userID);
    }
    catch(e){
      print(e);
    }
    emptySearchList();
  }

  Widget _buildPopupDialog(BuildContext context,userid) {
    return AlertDialog(
      title: const Text('Popup example'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            ElevatedButton(
              onPressed:(){
                removeMemberApi(widget.group.group_id, userid);
              }, 
              child: const Text("Remove")
            )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height:5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Group ${widget.group.group_name}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: GlobalVariables.greyFontColor
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(widget.group.description??'',style: TextStyle(color: GlobalVariables.greyFontColor))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:2,vertical: 20),
                child: Container(
                  height: 100,
                  child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: memberList.length,
                        scrollDirection:Axis.horizontal,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: () {
                               showDialog(
                                  context: context,
                                  builder: (BuildContext context) => _buildPopupDialog(context,memberList[index].user_id),
                                );
                            },
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                child: Column(
                                  children: [
                                    Container(
                                     
                                      child:  CircleAvatar(
                                                radius: 30, //radius of avatar
                                                backgroundColor: Colors.green, //color
                                                backgroundImage:NetworkImage('$uri/api/assets/image/user-profs/profile-0.jpg'),
                                              
                                            ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          memberList[index].username??'',
                                          style: const TextStyle(
                                            fontSize: 12
                                          ),
                                        ),
                                        // Container(
                                         
                                        //   height:30,
                                        //   child: ElevatedButton(
                                        //     onPressed: (){
                                        //         showDialog(
                                        //           context: context,
                                        //           builder: (BuildContext context) => _buildPopupDialog(context,memberList[index].user_id),
                                        //         );
                                        //     }, 
                                        //     child:Container( 
                                        //       child:const Icon(Icons.edit)
                                        //       )
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(
                      child: TextField(
                        decoration: InputDecoration(
                        suffixIcon: GestureDetector(child: Icon(Icons.search),
                        onTap:(){searchMemberApi();} ,),
                        hintText: "Seach by email address",
                        hintStyle:const TextStyle(color:Color.fromARGB(255, 161, 161, 161),fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderSide:const BorderSide(color:GlobalVariables.textFieldBgColor ),
                          borderRadius: BorderRadius.circular(20.0)
                        )
                        ),
                        controller: _searchvalue,
                        onChanged:(text){
                          if(text=='') setState(() {
                            searchMemberList.clear();
                          });
                        },
                      ),
                      width:MediaQuery.of(context).size.width*0.85 ,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // FloatingActionButton(
                      
                    //   backgroundColor: GlobalVariables.primaryColor,
                    //   child:Text("Search",style:TextStyle(color: Colors.white)),
                    //   onPressed:()async{
                    //     searchMemberApi();
                    //   } , )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchMemberList.length,
                  itemBuilder: (context, index){
                    return Container(
                      decoration:const BoxDecoration(
                        border: Border(
                          bottom:BorderSide(
                            color: GlobalVariables.textFieldBgColor
                          )
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 7, 17, 7),
                        child: Row(
                          children: [
                            Container(
                              child: CircleAvatar(
                                radius:30,
                                backgroundImage: NetworkImage('$uri/api/assets/image/user-profs/profile-0.jpg'),
                              )
                            ),
                            const SizedBox(width: 10,),
                            Row(
                            
                              
                              children: [
                                 Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     Text(searchMemberList[index].username??""),
                                      Text(searchMemberList[index].email??"",style:const TextStyle(fontSize: 12)),
                                  ],
                                ),
                                const SizedBox(width: 40,)
                                ,
                                (!listInt.contains(searchMemberList[index].user_id))?
                                ElevatedButton(
                                  style:ElevatedButton.styleFrom(
                                    backgroundColor: GlobalVariables.primaryColor
                                  ),
                                  child:const Text("Add",style: TextStyle(color: Colors.white),) ,
                                  onPressed:()async{
                                    addMemberApi(searchMemberList[index].user_id);
                                  }
                                ):
                               const SizedBox(width: 0,height: 0,)
                                
                               
                               
                              ],
                            ),
                           
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      )
     ,"Edit Task Group");
  }
}