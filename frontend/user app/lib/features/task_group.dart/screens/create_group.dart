import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/task_group.dart/services/set_group_services.dart';
import 'package:focusmi/features/task_group.dart/services/user_services.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/groupmembers.dart';

class CreateGroup extends StatefulWidget {
  static const String routeName = '/create_group';
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
    List<GroupMember> searchMemberList = List<GroupMember>.empty();
    List<GroupMember> selectedMemberList = List<GroupMember>.empty(growable: true);
    late final TextEditingController _searchvalue;
    late final TextEditingController _groupName;
    

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

  void creaetGroupApi()async{
    print("working");
    GroupService.createGroup(context: context, group_name: _groupName.text, status: 'Active', member_count: 1+selectedMemberList.length, group_id: 0, members: selectedMemberList);
  }

  var layout = LayOut();

  @override
  void initState() {
    super.initState();
    _groupName = TextEditingController();
    _searchvalue = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return layout.createGruopLayout(context,
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
           SizedBox(
                child: TextField(
                  controller: _groupName,
                  decoration: const InputDecoration(
                    hintText: "Enter Group Name"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:50.0),
                child: Container(
                  height: 200,
                  child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: selectedMemberList.length,
                        scrollDirection:Axis.horizontal,
                        itemBuilder: (context, index){
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(),
                              child: Row(
                                children: [
                                  Container(
                                    height:50,
                                    child: Image.network('$uri/api/assets/image/user-profs/team.png'),
                                  ),
                                  Column(
                                    children: [
                                      Text(selectedMemberList[index].username),
                                      // ElevatedButton(
                                      //   onPressed: (){
                                      //       showDialog(
                                      //         context: context,
                                      //         builder: (BuildContext context) => _buildPopupDialog(context,memberList[index].user_id),
                                      //       );
                                      //   }, 
                                      //   child: Text("Edit")
                                      // )
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  transformAlignment: Alignment.center,
                  decoration:const BoxDecoration(
                    color: GlobalVariables.primaryColor,
                    borderRadius:BorderRadius.all(
                        Radius.circular(10)
                    ),
                  ),
                  child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                        child: Container(
                          width:200,
                          child: TextField(
                            controller:_searchvalue,
                            decoration: InputDecoration(
                              filled:true,
                              hintText: "Enter a group name",
                              contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              fillColor: Colors.white,
                              hintStyle:const TextStyle(color:Color.fromARGB(255, 161, 161, 161) ,fontSize:13),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color:GlobalVariables.textFieldBgColor),
                                borderRadius: BorderRadius.circular(10.0)
                              )
                            ),
                            style: const TextStyle(
                              fontSize: 12,
                              color:Color.fromARGB(255, 161, 161, 161)
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          setState(() {
                            searchMemberApi();
                          });
                        }, 
                        child:const  Text("Add")
                      )
                    ],
                  ),
                  width:(MediaQuery.of(context).size.width)*0.9
                ),
              ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchMemberList.length,
                  itemBuilder: (context, index){
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(),
                        child: Column(
                          children: [
                            FloatingActionButton(
                              child:const Text("Add") ,
                              onPressed:()async{
                                searchMemberApi();
                              }
                            ),
                            Container(
                              child: Image.network('$uri/api/assets/image/user-profs/team.png'),
                            ),
                            Row(
                              children: [
                                Text(searchMemberList[index].username),
                                ElevatedButton(
                                onPressed: (){
                                  setState(() {
                                    selectedMemberList.add(searchMemberList[index]);
                                    print(selectedMemberList);
                                  });
                                }, 
                        child:const  Text("Add")
                      )
                              ],)
                          ],
                        ),
                      ),
                    );
                  }
                ),
                
            ],
          ),
        ),
      )
    ,"Create Task Group",creaetGroupApi);
  }
}