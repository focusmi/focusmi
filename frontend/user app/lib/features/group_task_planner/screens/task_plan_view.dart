// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/chat_application/screens/chat_page.dart';
import 'package:focusmi/features/group_task_planner/screens/single_task_view.dart';
import 'package:focusmi/features/group_task_planner/services/group_task_planner_services.dart';
import 'package:focusmi/features/pomodoro_timer/screens/pomodoro_timer_view.dart';
import 'package:focusmi/layouts/task_planner_layout.dart';
import 'package:focusmi/models/subtask.dart';
import 'package:focusmi/models/task.dart';
import 'package:focusmi/models/taskgroup.dart';
import 'package:focusmi/models/taskplan.dart';
import 'package:intl/intl.dart';

class GroupTaskPlanner extends StatefulWidget {
  static const String routeName = '/task_plan_view';
  final int group;
  final int? plan_id;

  const GroupTaskPlanner({
    Key? key,
    required this.group,
    required this.plan_id,
  }) : super(key: key);

  @override
  State<GroupTaskPlanner> createState() => _GroupTaskPlannerState();
}

class _GroupTaskPlannerState extends State<GroupTaskPlanner> {
  late Map<int, double> planHeight;
  int _selectedIndex = 0;
  Task entryTask = new Task(
      task_id: 0,
      plan_id: 0,
      timer_id: 0,
      duration: 0,
      task_status: '',
      priority: 0,
      created_at: '',
      color: '',
      task_type: 'group',
      description: '',
      is_text_field: true,
      task_name: '');
  late TextEditingController taskCreate;
  late List<TaskPlan> taskPlans;
  late ScrollController hcontroller;
  Map taskMap = Map();
  List<Task> tasks = List<Task>.empty(growable: true);
  late Map<int, Color?> color;
  List<SubTask> subTasks = List<SubTask>.empty(growable: true);
  List<TextEditingController> taskPlanControllers =
      List<TextEditingController>.empty(growable: true);
  late var taskPlanEditName;
  late int editplan;
  void initState() {
    taskPlanEditName = 0;
    color = {};
    editplan = 0;
    planHeight = {};
    taskCreate = TextEditingController();
    taskPlans = List<TaskPlan>.empty(growable: true);
    hcontroller = ScrollController();
    _getTaskPlan();
    goToTaskPlan();
    super.initState();
  }

  void refreshColor(taskid) async {
    var val = await GTaskPlannerServices.getTaskAttr('color', taskid);
    val = (json.decode(val.body))['value'];
    if (val == null || val == 'nocolor') {
      val = Color.fromARGB(255, 255, 255, 255);
    } else {
      val = val.split(':');
      int blue = int.parse(val[0]);
      int red = int.parse(val[1]);
      int green = int.parse(val[2]);
      val = Color.fromARGB(255, red, green, blue);
      setState(() {
        if (val == null || val == 'nocolor') {
          color[taskid] = null;
        } else {
          color[taskid] = val;
        }
      });
    }
  }

  void goToTaskPlan() async {
    try {
     
    } catch (e) {}
  }

  void completeTask(task_id) async {
    try {
      GTaskPlannerServices.setTaskAttr('status', task_id, 'completed');
      refreshTaskAllocation();
    } catch (e) {
      print(e);
    }
  }

  void refreshTaskAllocation() async {
    taskPlans.forEach((element) async {
      //get the tasks
      var result = await GTaskPlannerServices.getTaskByPlan(element.plan_id);
      //run the loop to create the list
      Iterable list = json.decode(result.body).cast<Map<String, dynamic>>();
      tasks = list.map((model) => Task.fromJson(model)).toList();
      for (Task element in tasks) {
        refreshColor(element.task_id);
      }
      //assign the loop in the set state
      setState(() {
        taskMap[element.plan_id] = tasks;
      });
    });
  }

  void addTaskPlan() async {
    var taskplanid = taskPlans.length + 1;
    var groupid = widget.group;
    var name = 'Task Plan - $taskplanid';
    taskplanid = await GTaskPlannerServices.createTaskPlan(TaskPlan(
        plan_id: taskplanid,
        group_id: groupid,
        plan_name: name,
        is_edit: true));
    Response response = await GTaskPlannerServices.getTaskPlanByGroup(groupid);
    setState(() {
      Iterable list = json.decode(response.body).cast<Map<String?, dynamic>>();
      taskPlans = list.map((model) => TaskPlan.fromJson(model)).toList();
      //fix here
      for (var plans in taskPlans) {
        taskMap[plans.plan_id] = List.empty(growable: true);
      }
    });
    refreshTaskAllocation();
    setState(() {
      editplan = taskplanid;
      planHeight[taskplanid] = 10;
      hcontroller.animateTo(
          hcontroller.position.maxScrollExtent +
              MediaQuery.of(context).size.width,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut);
    });
  }

  void addTask() {
    var taskid = taskMap[entryTask.plan_id].length + 1;
    Task newtask = Task(
        task_id: taskid,
        plan_id: entryTask.plan_id,
        timer_id: 0,
        duration: 0,
        task_type: 'group',
        task_status: 'pending',
        priority: 0,
        created_at: '2012-03-04',
        color: '',
        description: '',
        is_text_field: false,
        task_name: taskCreate.text);
    GTaskPlannerServices.addTask(newtask);
    setState(() {
      taskMap[entryTask.plan_id].add(newtask);
      entryTask.plan_id = 0;
    });
    setState(() {
      planHeight[entryTask.plan_id] = 0;
    });
  }

  void createTask(plan_id) {
    setState(() {
      taskMap.forEach((key, value) {
        var val = value.indexWhere((item) => item.task_id == 0);
        (val != -1) ? value.removeAt(val) : val = 0;
      });
      taskCreate.text = '';
      taskMap[plan_id].add(entryTask);
      entryTask.plan_id = plan_id;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPressedText(index) {
    setState(() {
      editplan = taskPlans[index].plan_id;
      taskPlanControllers[index].text = taskPlans[index].plan_name;
    });
  }

  void _addTaskPlanName(index) async {
    var groupid = widget.group;
    Response response = await GTaskPlannerServices.getTaskPlanByGroup(groupid);
    setState(() {
      taskPlans[index].plan_name = taskPlanControllers[index].text;
      print(taskPlans[index].plan_name);
    });
    setState(() {
      editplan = 0;
      GTaskPlannerServices.renameTaskPlan(taskPlans[index]);
      Iterable list = json.decode(response.body).cast<Map<String?, dynamic>>();
      taskPlans = list.map((model) => TaskPlan.fromJson(model)).toList();
      for (var plans in taskPlans) {
        taskMap[plans.plan_id] = List.empty(growable: true);
      }
      setState(() {
        taskPlans[index].plan_name = taskPlanControllers[index].text;
      });
      refreshTaskAllocation();
    });
  }

  void _getTaskPlan() async {
    var groupid = widget.group;
    Response response = await GTaskPlannerServices.getTaskPlanByGroup(groupid);
    Iterable list = json.decode(response.body).cast<Map<String?, dynamic>>();
    setState(() {
      taskPlans = list.map((model) => TaskPlan.fromJson(model)).toList();
      print(taskPlans);
      for (var plans in taskPlans) {
        taskMap[plans.plan_id] = List.empty(growable: true);
      }
      refreshTaskAllocation();
       if (widget.plan_id != null) {
        int index = taskPlans
            .indexWhere((element) => element.plan_id == widget.plan_id);
       
        setState(() {
          hcontroller.animateTo(MediaQuery.of(context).size.width * index,
              duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double planWidth = MediaQuery.of(context).size.width;
    return TaskPlannerLayout.mainBoard(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: taskPlans.length,
              scrollDirection: Axis.horizontal,
              controller: hcontroller,
              itemBuilder: (context, index) {
                taskPlanControllers.add(TextEditingController());
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          width: planWidth,
                          child: (taskPlans[index].plan_id != null &&
                                  taskPlans[index].plan_id != editplan)
                              ? GestureDetector(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: GlobalVariables
                                                        .textFieldBgColor))),
                                        child: Text(
                                          taskPlans[index].plan_name,
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: GlobalVariables
                                                  .greyFontColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _onPressedText(index);
                                    });
                                  },
                                )
                              : Row(
                                  children: [
                                    Container(
                                        width: planWidth * 0.8,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: TextField(
                                            decoration: InputDecoration(),
                                            style: TextStyle(fontSize: 24),
                                            controller:
                                                taskPlanControllers[index],
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
                                            _addTaskPlanName(index);
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: planWidth,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  taskMap[taskPlans[index].plan_id].length,
                              itemBuilder: (context, subindex) {
                                return ((taskMap[taskPlans[index].plan_id])[
                                                    subindex]
                                                .task_status !=
                                            'completed' ||
                                        (taskMap[taskPlans[index].plan_id])[
                                                    subindex]
                                                .task_status ==
                                            null)
                                    ? (((taskMap[taskPlans[index].plan_id])[
                                                    subindex]
                                                .task_name !=
                                            '')
                                        ? Container(
                                            width: planWidth,
                                            constraints: const BoxConstraints(
                                              minHeight: 70,
                                            ),
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: GlobalVariables
                                                        .textFieldBgColor),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  top: 8,
                                                  bottom: 0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                          context,
                                                          SingleTaskView
                                                              .routeName,
                                                          arguments: (taskMap[
                                                                  taskPlans[
                                                                          index]
                                                                      .plan_id]
                                                              [subindex]))
                                                      .then((value) => {
                                                            Navigator.pushNamed(
                                                                context,
                                                                GroupTaskPlanner
                                                                    .routeName)
                                                          });
                                                },
                                                child: Container(
                                                    width: planWidth,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 5, 0, 0),
                                                          child: Row(
                                                            children: [
                                                              Radio(
                                                                  value: taskMap[
                                                                              taskPlans[index].plan_id]
                                                                          [
                                                                          subindex]
                                                                      .task_id,
                                                                  groupValue:
                                                                      "",
                                                                  onChanged:
                                                                      (value) {
                                                                    completeTask(
                                                                      taskMap[taskPlans[index].plan_id]
                                                                              [
                                                                              subindex]
                                                                          .task_id,
                                                                    );
                                                                  }),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                      (taskMap[taskPlans[index].plan_id])[
                                                                              subindex]
                                                                          .task_name,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              GlobalVariables.greyFontColor),
                                                                    ),
                                                                  ),
                                                                  (((taskMap[taskPlans[index].plan_id])[subindex])
                                                                              .deadline_date !=
                                                                          null)
                                                                      ? Container(
                                                                          child:
                                                                              Text(
                                                                            DateFormat('MMM/d').format(DateTime.parse((((taskMap[taskPlans[index].plan_id])[subindex]).deadline_date).split(' ')[0])) ??
                                                                                '',
                                                                            style:
                                                                                TextStyle(color: Colors.red, fontSize: 12),
                                                                          ),
                                                                        )
                                                                      : SizedBox(
                                                                          width:
                                                                              0,
                                                                          height:
                                                                              0,
                                                                        ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: (color[taskMap[
                                                                              taskPlans[index].plan_id]
                                                                          [
                                                                          subindex]
                                                                      .task_id] !=
                                                                  null)
                                                              ? Container(
                                                                  decoration: BoxDecoration(
                                                                      color: color[taskMap[taskPlans[index].plan_id]
                                                                              [
                                                                              subindex]
                                                                          .task_id]),
                                                                  height: 5,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.80,
                                                                )
                                                              : SizedBox(
                                                                  height: 0,
                                                                  width: 0,
                                                                ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ))
                                        : SizedBox(
                                            width: 0,
                                            height: 0,
                                          ))
                                    : SizedBox(
                                        width: 0,
                                        height: 0,
                                      );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        (entryTask.plan_id != taskPlans[index].plan_id)
                            ? SizedBox(
                                width: planWidth * 0.90,
                                child: GestureDetector(
                                  child: DottedBorder(
                                    strokeWidth: 1,
                                    color: GlobalVariables.primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          child: Center(
                                        child: Text(
                                          "+ Add Task",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  GlobalVariables.primaryColor),
                                        ),
                                      )),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      createTask(taskPlans[index].plan_id);
                                    });
                                  },
                                ),
                              )
                            : Container(
                                width: planWidth,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: GlobalVariables
                                                .textFieldBgColor))),
                                child: Row(
                                  children: [
                                    Container(
                                      width: planWidth * 0.75,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 0, 0, 0),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      30, 0, 0, 0)),
                                          controller: taskCreate,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                GlobalVariables.primaryColor),
                                        onPressed: () {
                                          addTask();
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ))
                                  ],
                                ))
                      ],
                    ),
                  ),
                );
              }),
        ),
        ConvexAppBar(
          style: TabStyle.fixedCircle,
          backgroundColor: GlobalVariables.primaryColor,
          height: 60,
          curveSize: 100,
          top: -40,
          items: [
            TabItem(icon: Icons.group, title: 'Group'),
            TabItem(
                icon: ElevatedButton(
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.primaryColor,
                      side: BorderSide(width: 2, color: Colors.white),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20)),
                  onPressed: () {
                    addTaskPlan();
                  },
                ),
                title: 'Add'),
            TabItem(
              icon: GestureDetector(
                child: Container(
                    child: Icon(
                  Icons.chat,
                  color: Colors.white,
                )),
                onTap: () {
                  // Navigator.pushNamed(context, ChatRoom.routeName,
                  //     arguments: widget.group);
                 Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                               ChatPage(groupid: widget.group,)
                                          ),
                                        );
                },
              ),
              title: 'Chat',
            ),
          ],
          onTap: (int i) => print('click index=$i'),
        ),
        "Task Planner",
        context);
  }
}
