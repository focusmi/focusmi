import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/task_group.dart/screens/group_list.dart';
import 'package:focusmi/features/task_group.dart/services/set_group_services.dart';
import 'package:focusmi/features/task_group.dart/services/user_services.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/groupmembers.dart';
import 'package:focusmi/features/appointment/screens/add_appointment.dart';

class CreateGroup extends StatefulWidget {
  static const String routeName = '/create_group';
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<GroupMember> searchMemberList = List<GroupMember>.empty();
  List<GroupMember> selectedMemberList =
      List<GroupMember>.empty(growable: true);
  late final TextEditingController _searchvalue;
  late final TextEditingController _groupName;
  late final TextEditingController _description;
  late int addedMemberCount;
  late bool buttonToggle;
  late List<int> listInt = List<int>.empty(growable: true);
  void emptySearchList() {
    setState(() {
      searchMemberList = List<GroupMember>.empty();
    });
  }

  void removeMemberApi(userid) async {
    try {
      setState(() {
        selectedMemberList.removeWhere((element) => element.user_id == userid);
        listInt.remove(userid);
      });
    } catch (e) {
      print(e);
    }
    emptySearchList();
  }

  Future searchMemberApi() async {
    var members = await UserService.getUser(_searchvalue.text);
    setState(() {
      try {
        Iterable list = json.decode(members.body).cast<Map<String, dynamic>>();
        searchMemberList =
            list.map((model) => GroupMember.fromJson(model)).toList();
      } catch (e) {
        print(e);
        searchMemberList = List.empty();
      }
    });
  }

  void createGroupApi() async {
    try {
      GroupService.createGroup(
          context: context,
          group_name: _groupName.text,
          description:_description.text,
          status: 'Active',
          member_count: 1 + selectedMemberList.length,
          group_id: 0,
          members: selectedMemberList);
    } catch (e) {
      print(e);
    }
  }

  var layout = LayOut();

  @override
  void initState() {
    super.initState();
    _groupName = TextEditingController();
    _searchvalue = TextEditingController();
    _description = TextEditingController();
    buttonToggle = false;
  }

  @override
  Widget build(BuildContext context) {
    return layout.mainLayoutWithDrawer(
        context,
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    child: TextField(
                      controller: _groupName,
                      style: TextStyle(
                          fontSize: 12, color: GlobalVariables.greyFontColor),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: GlobalVariables.textFieldBgColor),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Enter Group Name",
                      ),
                      onChanged: (text) {
                        setState(() {
                          if (text != '' &&
                              selectedMemberList.isEmpty != true) {
                            buttonToggle = true;
                            print("true");
                          } else {
                            buttonToggle = false;
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  TextField(
                    controller: _description,
                    minLines: 3,
                    maxLines: 4,
                    style: TextStyle(
                        color: GlobalVariables.greyFontColor, fontSize: 12),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: GlobalVariables.textFieldBgColor,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Description",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text("Group Members",
                              style: TextStyle(
                                color: GlobalVariables.greyFontColor,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          (selectedMemberList.length == 0)
                              ? DottedBorder(
                                  color: GlobalVariables.textFieldBgColor,
                                  child: Container(
                                    height: 120,
                                    child: Center(
                                      child: Text(
                                        "+ Add group members",
                                        style: TextStyle(
                                            color:
                                                GlobalVariables.greyFontColor),
                                      ),
                                    ),
                                  ))
                              : Container(
                                  width: 500,
                                  height: 100,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: selectedMemberList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: Image.network(
                                                              '$uri/api/assets/image/user-profs/team.png')),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      child: Container(
                                                        child: Text('-',
                                                            style: TextStyle(
                                                                color: GlobalVariables
                                                                    .greyFontColor,
                                                                fontSize: 30)),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          removeMemberApi(
                                                              searchMemberList[
                                                                      index]
                                                                  .user_id);
                                                          emptySearchList();
                                                        });
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      selectedMemberList[index]
                                                              ?.username ??
                                                          '',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: GlobalVariables
                                                              .greyFontColor),
                                                    ),

                                                    // Container(
                                                    //   child: ElevatedButton(

                                                    //     style: ElevatedButton.styleFrom(
                                                    //       backgroundColor: GlobalVariables.primaryColor,
                                                    //       shape: CircleBorder(),
                                                    //       padding: EdgeInsets.all(4)
                                                    //     ),

                                                    //     onPressed: (){
                                                    //    removeMemberApi(searchMemberList[index].user_id);
                                                    //    emptySearchList();
                                                    //   },
                                                    //   child: Icon(Icons.remove)
                                                    //   ),
                                                    // )
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
                                      }),
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: _searchvalue,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.search),
                            onTap: () {
                              setState(() {
                                searchMemberApi();
                              });
                            },
                          ),
                          filled: true,
                          hintText: "Enter the  group name",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 161, 161, 161),
                              fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: GlobalVariables.textFieldBgColor),
                              borderRadius: BorderRadius.circular(10.0))),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 161, 161, 161)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchMemberList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                          '$uri/api/assets/image/user-profs/profile-0.jpg'),
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(searchMemberList[index].username ??
                                          ''),
                                      ((!listInt.contains(
                                              searchMemberList[index].user_id))
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: GlobalVariables
                                                    .primaryColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  selectedMemberList.add(
                                                      searchMemberList[index]);
                                                  listInt.add(
                                                      searchMemberList[index]
                                                          .user_id);
                                                  if (_groupName.text != '') {
                                                    buttonToggle = true;
                                                  }
                                                  emptySearchList();
                                                });
                                              },
                                              child: const Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))
                                          : (SizedBox(
                                              width: 0,
                                              height: 0,
                                            ))),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  (buttonToggle)
                      ? Container(
                          width: 200,
                          child: FloatingActionButton(
                              backgroundColor: GlobalVariables.primaryColor,
                              child: Text(
                                "Create Group",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                createGroupApi();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const GroupList(),
                                    ));
                              }),
                        )
                      : const Text('')
                ],
              ),
            ),
          ),
        ),
        "Create Task Group");
  }
}
