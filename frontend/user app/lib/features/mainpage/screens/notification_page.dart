import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/group_task_planner/screens/task_plan_view.dart';
import 'package:focusmi/features/group_task_planner/services/group_task_planner_services.dart';
import 'package:focusmi/features/mainpage/services/noti_services.dart';
import 'package:focusmi/features/task_group.dart/screens/edit_task_group.dart';
import 'package:focusmi/features/task_group.dart/screens/group_list.dart';
import 'package:focusmi/features/task_group.dart/services/set_group_services.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/notification.dart';
import 'package:focusmi/models/taskgroup.dart';
import 'package:avatar_glow/avatar_glow.dart';

class NotiList extends StatefulWidget {
  static const String routeName = '/notification_page';
  const NotiList({super.key});

  @override
  State<NotiList> createState() => _NotiListState();
}

class _NotiListState extends State<NotiList> {
  List<Notifications> characterList = List<Notifications>.empty(growable: true);
  List<TaskGroup> group = List<TaskGroup>.empty(growable: true);
  List<TaskGroup> thisgroup = List<TaskGroup>.empty(growable: true);
  Random random = Random();

  void getGroupsfromApi() async {
    GroupService.getGroups().then((response) {
      setState(() {
        try {
          Iterable list =
              json.decode(response.body).cast<Map<String?, dynamic>>();
          group = list.map((model) => TaskGroup.fromJson(model)).toList();
        } catch (e) {
          characterList = List.empty();
        }
      });
    });
  }

  Future getGroup(groupid) async {
    try {
      var result = await GTaskPlannerServices.getGroupById(groupid);
      var res = json.decode(result.body)[0];
      return TaskGroup(
          group_id: res['group_id'],
          group_name: res['group_name'],
          status: res['status'],
          member_count: res['member_count'],
          creator_id: res['creator_id'],
          created_at: res['created_at']);
    } catch (e) {
      print(e);
    }
  }

  void getNotifromApi() async {
    NotiServices.getNotification(context).then((response) async {
      setState(() {
        try {
          Iterable list =
              json.decode(response.body).cast<Map<String?, dynamic>>();
          characterList =
              list.map((model) => Notifications.fromJson(model)).toList();
        } catch (e) {
          print(e);
        }
      });

      for (Notifications element in characterList) {
        print("dfdfdfdfd");
        print(element.noti_id);
        var result = await getGroup(element.group_id);
        print(result);
        print("elemnt");
        // print(result);
        setState(() {
          thisgroup.add(result);
        });
        // print(element.group_id.toString() +
        //     "-" +
        //     elemento.group_id.toString());
        // if (elemento.group_id == element.group_id) {
        //   thisgroup.add(elemento);
        //   break;
        // }
      }
    });
  }

  void initState() {
    super.initState();
    getGroupsfromApi();
    getNotifromApi();
  }

  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();
    return layout.mainLayoutWithDrawer(
        context,
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: ListView.builder(
                  itemCount: characterList.length,
                  itemBuilder: (context, index) {
                    return (characterList[index].type == "invite")
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, GroupTaskPlanner.routeName,
                                      arguments: ([
                                        characterList[index].group_id,
                                        null
                                      ]));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                GlobalVariables.textFieldBgColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width:
                                                (MediaQuery.of(context).size.width),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  12, 5, 12, 0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${characterList[index].text}",
                                                                style: TextStyle(
                                                                    color: GlobalVariables
                                                                        .greyFontColor),
                                                              ),
                                                              Text(
                                                                "Group Name: ${thisgroup[index].group_name}",
                                                                style: TextStyle(
                                                                    color: GlobalVariables
                                                                        .greyFontColor),
                                                              ),
                                                              Text(
                                                                "Created On : ${((thisgroup[index].created_at)?.split("T"))?[0]}",
                                                                style: TextStyle(
                                                                    color: GlobalVariables
                                                                        .greyFontColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          GlobalVariables
                                                              .primaryColor),
                                                  onPressed: () {
                                                    GTaskPlannerServices
                                                        .editGroupMember(
                                                            characterList[index]
                                                                .group_id,
                                                            "member",
                                                            context);
                                                    GTaskPlannerServices.changeNoti(
                                                        characterList[index]
                                                            .noti_id,
                                                        "inactive");
                                                   Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GroupList(),
                                              ));
                                                  },
                                                  child: Text(
                                                    "Join Group",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container();
                  }),
            ),
          ],
        ),
        "Notifications");
  }
}
