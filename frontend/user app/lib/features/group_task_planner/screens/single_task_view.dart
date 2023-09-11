// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/groupmembers.dart';
import 'package:focusmi/models/subtask.dart';
import 'package:focusmi/models/task.dart';

class SingleTaskView extends StatefulWidget {
  static const routeName = '/single_task_view';
  final Task task;

  SingleTaskView({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<SingleTaskView> createState() => _SingleTaskViewState();
}

class _SingleTaskViewState extends State<SingleTaskView> {
  late List<SubTask> subTasks;
  late List<GroupMember> memberList;
  late List<GroupMember> showMemeberList;
  late List<GroupMember> selectedMemberList;
  late Map<GroupMember, List<GroupMember>> subTaskAllocation;
  late TextEditingController _searchValue;
  late Map<int, List<GroupMember>> _subTaskAllocation;
  late bool toggleInput;
  late TextEditingController _subtaskValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subTasks = List<SubTask>.empty(growable: true);
    subTaskAllocation = {};
    GroupMember dummyMember = GroupMember(
        1, 'Morgan Stern', 'stern@county.com', 'active', 'profile.jpg');
    GroupMember dummyMember1 = GroupMember(
        1, 'Willy Stern', 'Gunny@county.com', 'active', 'profile.jpg');
    GroupMember dummyMember2 = GroupMember(
        1, 'Rita Stern', 'rita@county.com', 'active', 'profile.jpg');
    memberList = List<GroupMember>.empty(growable: true);
    memberList.add(dummyMember);
    memberList.add(dummyMember1);
    memberList.add(dummyMember2);
    showMemeberList = List<GroupMember>.empty(growable: true);
    selectedMemberList = List<GroupMember>.empty(growable: true);
    _searchValue = TextEditingController();
    _subTaskAllocation = {};
    toggleInput = false;
    _searchValue = TextEditingController();
    _subtaskValue = TextEditingController();
  }

  void searchMember(text) {
    setState(() {
      showMemeberList.clear();
    });
    String val = text.toLowerCase();
    for (var member in memberList) {
      if (val != '') {
        var re = RegExp('^[a-zA-z]*${val}[a-zA-Z0-9]*');
        if (re.hasMatch(member.email.toLowerCase()) ||
            re.hasMatch(member.username.toLowerCase())) {
          setState(() {
            print(member.username);
            showMemeberList.add(member);
          });
        }
      } else {
        setState(() {
          showMemeberList.clear();
        });
      }
    }
  }

  void addMember(member) {
    setState(() {
      selectedMemberList.add(member);
    });
  }

  void addSubTask(taskname, taskid) {
    setState(() {
      subTasks.add(SubTask(
      stack_id: subTasks.length + 1,
      task_id: taskid,
      sub_priority: 0,
      sub_label: taskname,
      sub_status: 'pending',
      created_at: ''));
      _subTaskAllocation[subTasks.length] = [];
    });
  }

  void allocateMember(GroupMember member, subtask) {
    setState(() {
      _subTaskAllocation[subtask]?.add(member);
    });
  }

  Widget _buildAddMemberPopup(BuildContext context, subtaskid) {
    return AlertDialog(
      title:const Text("Add Member"),
      content: StatefulBuilder(
        builder: (BuildContext , StateSetter setState) {
          return Container(
            width: 200,
            child: Column(
              children: [
                TextField(
                  controller: _searchValue,
                  onChanged: (text) {
                    setState(() {
                      showMemeberList.clear();
                    });
                    String val = text.toLowerCase();
                    for (var member in memberList) {
                      if (val != '') {
                        var re = RegExp('^[a-zA-z]*${val}[a-zA-Z0-9]*');
                        if (re.hasMatch(member.email.toLowerCase()) ||
                            re.hasMatch(member.username.toLowerCase())) {
                          setState(() {
                            showMemeberList.add(member);
                          });
                        }
                      } else {
                        setState(() {
                          showMemeberList.clear();
                        });
                      }
                    }
                  },
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: showMemeberList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          allocateMember(showMemeberList[index], subtaskid);
                        },
                        child: Row(
                          children: [
                            //Image.network('$uri/api/assets/image/user-profs/team.png'),
                            Column(
                              children: [
                                Text(showMemeberList[index].username),
                                Text(showMemeberList[index].email),
                              ],
                            )
                          ],
                        ),
                      );
                    })
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();
    return layout.mainLayoutWithDrawer(
        context,
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("Task :" + widget.task.task_name),
                  (widget.task.description != '')
                      ? Text("Description" + widget.task.description)
                      : SizedBox(
                          width: 0,
                          height: 0,
                        ),
                  Text("Created On :" + widget.task.created_at)
                ]),
                Container(
                  child: Column(
                    children: [
                      ListView.builder(
                          itemCount: subTasks.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(subTasks[index].sub_label),
                                      ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  _buildAddMemberPopup(
                                                      context,
                                                      memberList[index]
                                                          .user_id),
                                            );
                                          },
                                          child: const Icon(Icons.add))
                                    ],
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:_subTaskAllocation[subTasks[index].task_id]?.length,
                                      itemBuilder: (context, subindex) {
                                        return Text(_subTaskAllocation[subTasks[index].task_id]?[subindex].username ??'');
                                      })
                                ],
                              ),
                            );
                          }),
                      (toggleInput)
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: TextField(
                                    controller: _subtaskValue,
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        addSubTask(_subtaskValue.text, 1);
                                        _subtaskValue.text = '';
                                        toggleInput = false;
                                      });
                                    },
                                    child: const Text("Add"))
                              ],
                            )
                          : GestureDetector(
                              child: Container(
                                child: const Text("Add Task"),
                              ),
                              onTap: () {
                                setState(() {
                                  toggleInput = true;
                                });
                              },
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        "Edit Task");
  }
}
