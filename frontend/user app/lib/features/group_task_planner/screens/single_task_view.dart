// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:focusmi/features/authentication/screens/packages_page.dart';
import 'package:focusmi/features/group_task_planner/widget/dropdown.dart';
import 'package:focusmi/features/group_task_planner/widget/mydropdown.dart';
import 'package:focusmi/features/group_task_planner/widget/userimage.dart';
import 'package:focusmi/features/mainpage/screens/main_page.dart';
import 'package:focusmi/features/task_group.dart/services/set_group_services.dart';
import 'package:focusmi/models/taskplan.dart';
import 'package:tap_canvas/tap_canvas.dart';
//import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/group_task_planner/services/group_task_planner_services.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/groupmembers.dart';
import 'package:focusmi/models/subtask.dart';
import 'package:focusmi/models/task.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:focusmi/widgets/texts.dart';

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
  late DateTime dateTime;
  late String? showDateTime;
  late String? showDateTime2;
  late DateTime now;
  late String? nowtime;
  late String? showTime;
  late String? nowtime2;
  late String? showTime2;
  late Color? label;
  late bool changeTitle;
  late TextEditingController _titleName;
  late String title;
  late TextEditingController description;
  late String? descriptionval;
  late bool setdescription;
  late Map<int, bool> subAllocated;
  late List<TaskPlan> taskPlan;
  late List<TaskPlan> taskNames;
  late List<GroupMember> taskUser;
  late String? taskLocation;
  late String? reminder_date;
  late String? reminder_time;

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subTasks = [];
    taskUser = [];
    subTaskAllocation = {};
    0;
    memberList = List<GroupMember>.empty(growable: true);
    showMemeberList = List<GroupMember>.empty(growable: true);
    selectedMemberList = List<GroupMember>.empty(growable: true);
    _searchValue = TextEditingController();
    _subTaskAllocation = {};
    toggleInput = false;
    _searchValue = TextEditingController();
    _subtaskValue = TextEditingController();
    _titleName = TextEditingController();
    description = TextEditingController();
    taskPlan = [];
    setdescription = false;
    // fixed the date to taday\
    now = DateTime.now();
    dateTime = DateTime(now.year, now.month, now.day);
    showDateTime = null;
    showTime = null;
    nowtime = '';
    showDateTime2 = null;
    showTime2 = null;
    reminder_date = null;
    reminder_time = null;
    taskLocation = null;
    nowtime2 = '';
    descriptionval = '';
    subAllocated = {};
    label = Color.fromARGB(255, 255, 255, 255);
    title = '';
    taskNames = [];
    refreshColor(widget.task.task_id);
    refreshTaskName(widget.task.task_id);
    refreshDeadline(widget.task.task_id);
    getTaskPlanByPlanID(widget.task.plan_id);
    refreshTaskList();
    refreshTaskAllocation();
    refreshSubTaskAllocation();
    refreshTaskDescription();
    checkSubTaskUser();
    refreshTaskLocation();
    changeTitle = false;
    refreshGroupUsers();
    refreshAlarm();
  }

  void refreshAlarm() async {
    try {
      var time = await GTaskPlannerServices.getTaskAttr(
          "reminder_time", widget.task.task_id);
      var date = await GTaskPlannerServices.getTaskAttr(
          "reminder_date", widget.task.task_id);
      var reminderDate = json.decode(date.body)['value'];
      var reminderTime = json.decode(time.body)['value'];

      if (reminderDate != null && reminderTime != null) {
        setState(() {
          reminder_date = reminderDate;
          reminder_time = reminderTime;
        });
      }
    } catch (e) {}
  }

  void chanageColorApi(taskid, color) {
    try {
      GTaskPlannerServices.setTaskAttr('color', taskid, color);
      setState(() {});
    } catch (e) {}
  }

  void chanageDeadlineApi(taskid, deadline_time, deadline_date) {
    try {
      GTaskPlannerServices.setTaskAttr('deadline_date', taskid, deadline_date);
      GTaskPlannerServices.setTaskAttr('deadline_time', taskid, deadline_time);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void refreshTaskLocation() async {
    try {
      print("location here");
      var result = await GTaskPlannerServices.getTaskAttr(
          'location', widget.task.task_id);
      setState(() {
        taskLocation = json.decode(result.body)["value"];
      });
    } catch (e) {
      print(e);
    }
  }

  void chanageReminderApi(taskid, deadline_time, deadline_date) {
    try {
      GTaskPlannerServices.setTaskAttr('reminder_date', taskid, deadline_date);
      GTaskPlannerServices.setTaskAttr('reminder_time', taskid, deadline_time);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void changeTaskNmae(task_id) async {
    try {
      GTaskPlannerServices.setTaskAttr('task_name', task_id, _titleName.text);
      ;
    } catch (e) {
      print(e);
    }
  }

  Future refreshTaskName(task_id) async {
    var result = await GTaskPlannerServices.getTaskAttr('task_name', task_id);
    print(result.body);
    setState(() {
      if (json.decode(result.body)['value'] == null) {
        _titleName.text = widget.task.task_name;
        title = widget.task.task_name;
      } else {
        title = json.decode(result.body)['value'];
        _titleName.text = title;
      }
    });
  }

  void refreshDeadline(task_id) async {
    var date = await GTaskPlannerServices.getTaskAttr('deadline_date', task_id);
    var time = await GTaskPlannerServices.getTaskAttr('deadline_time', task_id);
    date = jsonDecode(date.body)['value'];
    time = jsonDecode(time.body)['value'];
    if (date != null && time != null) {
      setState(() {
        showDateTime = date;
        showTime = time;
      });
    }
  }

  void refreshColor(taskid) async {
    var val =
        await GTaskPlannerServices.getTaskAttr('color', widget.task.task_id);
    val = (json.decode(val.body))['value'];
    if (val == null || val == 'nocolor') {
      val = Color.fromARGB(255, 255, 255, 255);
    } else {
      val = val.split(':');
      int blue = int.parse(val[0]);
      int red = int.parse(val[1]);
      int green = int.parse(val[2]);
      val = Color.fromARGB(255, red, green, blue);
    }
    setState(() {
      label = val;
    });
  }

  void searchMember(text) {
    setState(() {
      showMemeberList.clear();
    });
    String val = text.toLowerCase();
    for (var member in memberList) {
      if (val != '') {
        var re = RegExp('^[a-zA-z]*${val}[a-zA-Z0-9]*');
        if (re.hasMatch(member.email?.toLowerCase() ?? '') ||
            re.hasMatch(member.username!.toLowerCase())) {
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
  }

  void addMember(member) {
    setState(() {
      selectedMemberList.add(member);
    });
  }

  void addSubTask(taskname, taskid) {
    setState(() {
      SubTask stask = SubTask(
          stask_id: subTasks.length + 1,
          task_id: taskid,
          sub_priority: '0',
          sub_label: taskname,
          sub_status: 'pending',
          created_at: '');
      subTasks.add(stask);
      GTaskPlannerServices.createSubTask(stask);
    });
    refreshTaskList();
  }

  void allocateMember(GroupMember member, subtask) {
    setState(() {
      _subTaskAllocation[subtask]?.add(member);
      GTaskPlannerServices.setSubTaskUser(subtask, member.user_id);
      GTaskPlannerServices.setTaskUser(widget.task.task_id, member.user_id);
    });
  }

  Future<void> refreshSubTaskAllocation() async {}

  Future<void> refreshTaskAllocation() async {
    try {
      var result =
          await GTaskPlannerServices.getSubTaskUser(widget.task.task_id);
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      List<GroupMember> groupMember =
          list.map((model) => GroupMember.fromJson(model)).toList();
      setState(() {
        taskUser = groupMember;
      });
    } catch (e) {}
  }

  void refreshTaskList() async {
    try {
      var result =
          await GTaskPlannerServices.getAllSubTask(widget.task.task_id);
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      setState(() {
        subTasks = list.map((model) => SubTask.fromJson(model)).toList();
        for (SubTask task in subTasks) {
          subAllocated?[task.stask_id ?? 0] = false;
          _subTaskAllocation[task.stask_id ?? 0] = [];
        }
        checkSubTaskUser();
      });
    } catch (e) {
      print("----------");
      print(e);
    }
    try {
      for (SubTask subTask in subTasks) {
        var result =
            await GTaskPlannerServices.getSubTaskUser(subTask.stask_id);
        print("-------");
        print(json.decode(result.body)["value"]);
        print("-------");
        Iterable list =
            json.decode(result.body)["value"].cast<Map<String?, dynamic>>();
        List<GroupMember> groupMember =
            list.map((model) => GroupMember.fromJson(model)).toList();
        setState(() {
          _subTaskAllocation[subTask.stask_id ?? 0] = groupMember;
        });
        print("--------------------------------------");
      }
    } catch (e) {
      print(e);
    }
  }

  void addTaskLocation(location) {
    try {
      GTaskPlannerServices.setTaskAttr(
          'location', widget.task.task_id, location);
    } catch (e) {
      print("error in the location");
      print(e);
    }
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 1, now.month, now.day));

  Future<TimeOfDay?> pickTime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());

  void setDeadline() async {
    DateTime? resultDate = await pickDate();
    if (resultDate != null) {
      TimeOfDay? resultTime = await pickTime();
      setState(() {
        showDateTime = resultDate.toString().split(" ")[0];
      });
      if (resultDate != null) {
        setState(() {
          showTime = resultTime?.format(context);
          chanageDeadlineApi(
              widget.task.task_id, resultTime?.format(context), showDateTime);
        });
      }
    }
  }

  void setReminder() async {
    DateTime? resultDate = await pickDate();
    if (resultDate != null) {
      TimeOfDay? resultTime = await pickTime();
      setState(() {
        showDateTime2 = resultDate.toString();
      });
      if (resultDate != null) {
        setState(() {
          reminder_date = showDateTime2;
          reminder_time = resultTime?.format(context);
          showTime2 = resultTime?.format(context);
          chanageReminderApi(
              widget.task.task_id, resultTime?.format(context), showDateTime2);
        });
        GTaskPlannerServices.setAlarm(
            reminder_date, reminder_time, widget.task.task_id);
      }
    }
  }

  void changeTaskPlan(taskid, val) async {
    try {
      GTaskPlannerServices.setTaskAttr('plan_id', taskid, val);
    } catch (e) {
      print(e);
    }
  }

  void changeTaskDescription() async {
    try {
      print("------------");
      print(description.text);
      GTaskPlannerServices.setTaskAttr(
          'description', widget.task.task_id, description.text);
    } catch (e) {
      print(e);
    }
  }

  void editDescription() {
    setState(() {
      description.text = descriptionval ?? '';
      setdescription = true;
    });
  }

  void refreshTaskDescription() async {
    try {
      var result = await GTaskPlannerServices.getTaskAttr(
          'description', widget.task.task_id);
      result = json.decode(result.body);
      setState(() {
        descriptionval = result['value'];
      });
    } catch (e) {}
  }

  void refreshGroupUsers() async {
    try {
      var result =
          await GroupService.getGroupMemberByTaskID(widget.task.task_id);
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      setState(() {
        memberList = list.map((model) => GroupMember.fromJson(model)).toList();
      });
    } catch (e) {}
  }

  Future checkSubTaskUser() async {
    try {
      for (SubTask sub in subTasks) {
        var result = await GTaskPlannerServices.getSubTaskUser(sub.stask_id);
        print(sub.sub_label);
        setState(() {
          if (json.decode(result.body)['value'] == 0) {
            subAllocated[sub.stask_id ?? 0] = false;
          } else {
            subAllocated[sub.stask_id ?? 0] = true;
          }
        });
      }
    } catch (e) {}
  }

  Future getTaskPlanByPlanID(planid) async {
    try {
      var result = await GTaskPlannerServices.getTaskPlansByPlan(planid);
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      setState(() {
        taskPlan = list.map((model) => TaskPlan.fromJson(model)).toList();
        taskNames = taskPlan.map((model) => model).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildAddMemberPopup(BuildContext context, subtaskid) {
    return AlertDialog(
      title: const Text("Add Member"),
      content: StatefulBuilder(
        builder: (BuildContext, StateSetter setState) {
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
                        if (re.hasMatch(member.email!.toLowerCase()) ||
                            re.hasMatch(member.username!.toLowerCase())) {
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
                //member list
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: showMemeberList.length,
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
                                Text(showMemeberList[index].username ?? ''),
                                Text(showMemeberList[index].email ?? ''),
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

  Widget _changePlanPopup(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Move Task"),
      content: Container(
        height: 300,
        alignment: Alignment.topCenter,
        child: StatefulBuilder(
          builder: (BuildContext, StateSetter setState) {
            return Container(
              alignment: Alignment.topCenter,
              child: DropDownList(
                  items: taskNames,
                  taskplanid: widget.task.plan_id,
                  taskid: widget.task.task_id),
            );
          },
        ),
      ),
    );
  }

  Widget _changeMyPlanPopup(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Move Task"),
      content: Container(
        height: 300,
        alignment: Alignment.topCenter,
        child: StatefulBuilder(
          builder: (BuildContext, StateSetter setState) {
            return Container(
              alignment: Alignment.topCenter,
              child: MyDropDownList(taskid: widget.task.task_id),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double planWidth = MediaQuery.of(context).size.width;
    LayOut layout = LayOut();
    return layout.mainLayoutWithDrawerFloatingBtn(
        context,
        SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: (changeTitle == true)
                                ? Row(
                                    children: [
                                      Container(
                                          width: planWidth * 0.7,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: TextField(
                                              decoration: InputDecoration(),
                                              style: TextStyle(fontSize: 24),
                                              controller: _titleName,
                                            ),
                                          )),
                                      SizedBox(
                                        child: ElevatedButton(
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              shape: CircleBorder(),
                                              backgroundColor:
                                                  GlobalVariables.primaryColor),
                                          onPressed: () {
                                            setState(() {
                                              changeTitle = false;
                                              changeTaskNmae(
                                                  widget.task.task_id);
                                            });
                                            setState(() {
                                              if (_titleName.text != '') {
                                                title = _titleName.text;
                                              }
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () => {
                                      setState(() {
                                        changeTitle = true;
                                      })
                                    },
                                    child: Text(title,
                                        style: TextStyle(
                                            fontSize: 24,
                                            color:
                                                GlobalVariables.greyFontColor)),
                                  ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ((descriptionval != null && descriptionval != '') &&
                                  setdescription == false)
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      editDescription();
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text((descriptionval ?? '')),
                                  ),
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Icon(Icons.line_weight_sharp),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: planWidth * 0.8,
                                      height: 60,
                                      alignment: Alignment.topLeft,
                                      child: TextField(
                                        controller: description,
                                        onChanged: (val) {
                                          changeTaskDescription();
                                        },
                                        maxLines: 4,
                                        style: TextStyle(fontSize: 14),
                                        decoration: InputDecoration(
                                            hintText: "Add Description Here",
                                            hintStyle: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 10,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: label),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: GlobalVariables.textFieldBgColor,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 10),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      SubscriptionPackagesPage.routeName);
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    setReminder();
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor:
                                              Color.fromARGB(255, 21, 211, 218),
                                          child: Icon(
                                            Icons.alarm,
                                            color: Colors.white,
                                          )),
                                      (reminder_date == null ||
                                              reminder_time == null)
                                          ? Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              224,
                                                              170,
                                                              6)),
                                                  height: 13,
                                                  width: 17,
                                                  child: Center(
                                                    child: Text(
                                                      "Pro",
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Set Reminder",
                                                  style: TextStyle(
                                                      color: GlobalVariables
                                                          .greyFontColor,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Text(
                                                  (reminder_date)
                                                          ?.split(' ')[0] ??
                                                      '',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  reminder_time ?? '',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 21,
                            ),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _changePlanPopup(context));
                                },
                                child: const Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 123, 17, 211),
                                        child: Icon(
                                          Icons.format_list_bulleted,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      "Change Taskplan",
                                      style: TextStyle(
                                        color: GlobalVariables.greyFontColor,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 21,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _changeMyPlanPopup(context));
                              },
                              child: Container(
                                child: const Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: Colors.amber,
                                        child: Icon(
                                          Icons.move_to_inbox,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      "Add to My Tasks",
                                      style: TextStyle(
                                          color: GlobalVariables.greyFontColor,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: GlobalVariables.textFieldBgColor,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.label,
                                color: GlobalVariables.greyFontColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Label :",
                                  style: TextStyle(
                                      color: GlobalVariables.greyFontColor)),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 220,
                                child: BlockPicker(
                                  onColorChanged: (color) {
                                    setState(() {
                                      label = color;
                                      int? blue = label?.blue;
                                      int? red = label?.red;
                                      int? green = label?.green;
                                      double? opacity = label?.opacity;
                                      String strcolor =
                                          '${blue}:${red}:${green}:${opacity}';
                                      GTaskPlannerServices.setTaskAttr('color',
                                          widget.task.task_id, strcolor);
                                    });
                                  },
                                  pickerColor: Colors.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(),
                          Container(
                            width: 15,
                            height: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: GlobalVariables.textFieldBgColor,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          (showDateTime != null)
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      color: GlobalVariables.greyFontColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setDeadline();
                                      },
                                      child: Text(
                                        "Edit Deadline",
                                        style: TextStyle(
                                            color:
                                                GlobalVariables.greyFontColor),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  width: 0,
                                  height: 0,
                                ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              (showDateTime != null)
                                  ? CustomText.normalText('Date :')
                                  : SizedBox(
                                      width: 0,
                                      height: 0,
                                    ),
                              (showDateTime != null)
                                  ? CustomText.normalText(showDateTime ?? '')
                                  : SizedBox(
                                      width: 0,
                                      height: 0,
                                    ),
                              (showDateTime != null)
                                  ? const SizedBox(
                                      width: 20,
                                    )
                                  : SizedBox(
                                      width: 0,
                                      height: 0,
                                    ),
                              (showTime != null)
                                  ? CustomText.normalText('Time :')
                                  : SizedBox(
                                      width: 0,
                                      height: 0,
                                    ),
                              (showTime != null)
                                  ? CustomText.normalText(showTime ?? '')
                                  : SizedBox(
                                      width: 0,
                                      height: 0,
                                    ),
                              (showDateTime == null)
                                  ? Row(children: [
                                    
                                      GestureDetector(
                                          onTap: () {
                                            setDeadline();
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.schedule,
                                                color: GlobalVariables
                                                    .greyFontColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              CustomText.normalText(
                                                  "Set Deadline"),
                                            ],
                                          )),
                                    ])
                                  : SizedBox(
                                      width: 0,
                                      height: 0,
                                    ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 0),
                              Icon(
                                Icons.add_location,
                                color: GlobalVariables.greyFontColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => PlacePicker(
                                  //       apiKey:
                                  //           "AIzaSyDp9s9hdUOnbOBIQQjR1_goCMPJYsDEukk",
                                  //       onPlacePicked: (PickResult result) {
                                  //         setState(() {
                                  //           taskLocation =
                                  //               result.formattedAddress;
                                  //         });
                                  //         addTaskLocation(
                                  //             "${result.formattedAddress}");
                                  //         Navigator.of(context).pop();
                                  //       },
                                  //       initialPosition: kInitialPosition,
                                  //       useCurrentLocation: true,
                                  //       ignoreLocationPermissionErrors: true,
                                  //       resizeToAvoidBottomInset:
                                  //           false, // only works in page mode, less flickery, remove if wrong offsets
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Column(
                                  children: [
                                    (taskLocation != null)
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: Text(
                                                          '${taskLocation}',style: TextStyle(
                                                            color: GlobalVariables.greyFontColor
                                                          ),)))
                                            ],
                                          )
                                        : Text(
                                            "Add Location",
                                            style: TextStyle(
                                                color: GlobalVariables
                                                    .greyFontColor),
                                          ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Sub Tasks",
                      style: TextStyle(
                          color: GlobalVariables.greyFontColor, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            itemCount: subTasks.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return TapOutsideDetectorWidget(
                                onTappedOutside: () {
                                  setState(() {
                                    subTasks.removeLast();
                                  });
                                },
                                child: (subAllocated?[index] == false)
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Container(
                                          child: Text(
                                              subTasks[index].sub_label ?? ''),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: GlobalVariables
                                                    .textFieldBgColor,
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 32,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        child: CustomText
                                                            .normalText(subTasks[
                                                                        index]
                                                                    .sub_label ??
                                                                ''),
                                                        width: 315,
                                                      ),
                                                      Container(
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    _buildAddMemberPopup(
                                                                        context,
                                                                        subTasks[index]
                                                                            .stask_id),
                                                              );
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      color: Colors
                                                                          .white),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: GlobalVariables
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                (_subTaskAllocation[
                                                                subTasks[index]
                                                                    .stask_id]
                                                            ?.length !=
                                                        0)
                                                    ? Container(
                                                        height: 80,
                                                        decoration: const BoxDecoration(
                                                            border: Border(
                                                                top: BorderSide(
                                                                    color: GlobalVariables
                                                                        .textFieldBgColor))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 20,
                                                                  horizontal:
                                                                      5),
                                                          child: Row(
                                                            children: [
                                                              Center(
                                                                child:
                                                                    Container(
                                                                  width: 330,
                                                                  child: ListView
                                                                      .builder(
                                                                          shrinkWrap:
                                                                              true,
                                                                          scrollDirection: Axis
                                                                              .horizontal,
                                                                          itemCount: _subTaskAllocation[subTasks[index].stask_id]
                                                                              ?.length,
                                                                          itemBuilder:
                                                                              (context, subindex) {
                                                                            return Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                child: UserImage.createUserImage((_subTaskAllocation[subTasks[index].stask_id])?[0]));
                                                                          }),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: 0,
                                                        height: 0,
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                              );
                            }),
                        (toggleInput)
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            GlobalVariables.textFieldBgColor)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 5),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: TextField(
                                          controller: _subtaskValue,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              addSubTask(_subtaskValue.text,
                                                  widget.task.task_id);
                                              _subtaskValue.text = '';
                                              toggleInput = false;
                                            });
                                          },
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: GlobalVariables
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: GlobalVariables
                                                        .textFieldBgColor)),
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            : GestureDetector(
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Text(
                                      "+Add Sub Task",
                                      style: TextStyle(
                                          color: GlobalVariables.greyFontColor),
                                    ),
                                  ),
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
        ),
        "Edit Task",
        widget.task);
  }
}
