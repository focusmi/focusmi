import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/group_task_planner/screens/single_task_view.dart';
import 'package:focusmi/features/group_task_planner/services/group_task_planner_services.dart';
import 'package:focusmi/features/mainpage/widgets/category_tile.dart';
import 'package:focusmi/features/pomodoro_timer/screens/break_view.dart';
import 'package:focusmi/features/pomodoro_timer/services/pomodoro_timer_services.dart';
import 'package:focusmi/models/subtask.dart';
import 'package:focusmi/models/task.dart';
import 'package:focusmi/models/taskplan.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key, required this.task});
  final Task task;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _selectedValue = 8;
  // Step 2
  Timer? countdownTimer;
  late List<SubTask> subtasks;
  Duration myDuration = Duration(days: 5);
  late int hour;
  late int minute;
  late String hours;
  late String minutes;
  late int duration;
  late int bduration;
  late bool isBreak;
  late TextEditingController hcontroller;
  late TextEditingController mcontroller;
  late int tduration;
  late int totPomodoros;
  late int remPomodoros;
  late CountDownController controller;
  late CountDownController controller2;
  @override
  void initState() {
    //
    hour = 0;
    totPomodoros = 0;
    remPomodoros = 0;
    minute = 20;
    subtasks = [];
    controller = CountDownController();
    controller2 = CountDownController();
    duration = 5;
    bduration = 0;
    isBreak = false;
    hcontroller = TextEditingController();
    mcontroller = TextEditingController();
    super.initState();
    refreshTaskAllocation();
    setTimers(context);
    getTasks();
    String strDigits(int n) => n.toString().padLeft(2, '0');

    if (hour == 0) {
      hours = strDigits(0);
    } else {
      hours = strDigits(myDuration.inHours.remainder(hour + 1));
    }
    if (minute == 0) {
      minutes = strDigits(0);
    } else {
      minutes = strDigits(minute);
    }
    print(minute);
  }

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 5));
  }

  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void setTimers(context) async {
    var result = await PomodoroTimerServices.getTime(context);

    setState(() {
      duration = result['duration'];
      bduration = result['break'];

      if (result['duration'] < 60) {
        hour = 0;
      } else {
        hour = (result['duration']) ~/ 60;
      }
      minute = result['duration'] - hour * 60;
    });
  }

  // showing task methods
  void getTasks() async {
    try {
      var result =
          await GTaskPlannerServices.getAllSubTask(widget.task.task_id);
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      setState(() {
        subtasks = list.map((model) => SubTask.fromJson(model)).toList();
      });
      print("----------");
      print(subtasks);
    } catch (e) {
      print("error in getTask in countdown timer");
    }
  }

  void refreshTaskAllocation() async {
    subtasks.forEach((element) async {
      //get the tasks
      var result = await GTaskPlannerServices.getAllSubTask(element.task_id);
      //run the loop to create the list
      Iterable list = json.decode(result.body).cast<Map<String, dynamic>>();
      subtasks = list.map((model) => SubTask.fromJson(model)).toList();
      //assign the loop in the set state
      setState(() {
        subtasks = subtasks;
      });
    });
  }

  void CalculatePomodoros() async {
    try {
      var totMinutes =
          (int.parse(hcontroller.text) * 60) + int.parse(mcontroller.text);
      var value = (totMinutes / (duration + bduration)).ceil();
      setState(() {
        remPomodoros = value;
        totPomodoros = value;
      });
      print(value);
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

  void setBreak(bool val) {
    setState(() {
      isBreak = val;
      print(isBreak);
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    double planWidth = MediaQuery.of(context).size.width;

    if (hour == 0) {
      hours = strDigits(0);
    } else {
      hours = strDigits(myDuration.inHours.remainder(hour + 1));
    }
    if (minute == 0) {
      minutes = strDigits(0);
    } else {
      minutes = strDigits(myDuration.inMinutes.remainder(minute));
    }

    Widget _setDurationPopup(BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Move Task"),
        content: StatefulBuilder(
          builder: (BuildContext, StateSetter setState) {
            return Container(
              height: 300,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("Hours"),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: TextField(
                          controller: hcontroller,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Minutes"),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: TextField(
                          controller: mcontroller,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          CalculatePomodoros();
                          Navigator.pop(context);
                        },
                        child: Text("Add Duration")),
                  )
                ],
              ),
            );
          },
        ),
      );
    }
    //final minutes = strDigits(myDuration.inMinutes.remainder(minute));

    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/stars.jpg"), fit: BoxFit.cover)),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Duration",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          duration.toString() + " min",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
                    SizedBox(
                      width: 70,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _setDurationPopup(context));
                            },
                            child: Container(
                              child: Text("Pomodoros",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          (totPomodoros != 0)
                              ? Row(
                                  children: [
                                    Text(
                                      remPomodoros.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "/",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      totPomodoros.toString(),
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                )
                              : SizedBox(width: 0, height: 0)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Break",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          bduration.toString() + " min",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  child: NeonCircularTimer(
                    width: 200,
                    duration: 5,
                    controller: controller,
                    autoStart: false,
                    isReverse: true,
                    onComplete: () {
                      setState(() {
                        print("complete");
                        setBreak(true);
                        Navigator.pushNamed(context, BreakView.routeName,arguments:[widget.task,bduration]);
                      });
                    },
                  ),
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (_) => SizedBox(
                              width: double.infinity,
                              height: 250,
                              child: CupertinoPicker(
                                backgroundColor: Colors.white,
                                itemExtent: 30,
                                scrollController:
                                    FixedExtentScrollController(initialItem: 1),
                                children: [
                                  Text('5 min'),
                                  Text('10 min'),
                                  Text('15 min'),
                                  Text('20 min'),
                                  Text('25 min'),
                                  Text('30 min'),
                                  Text('35 min'),
                                  Text('40 min'),
                                  Text('45 min'),
                                  Text('50 min'),
                                  Text('55 min'),
                                ],
                                onSelectedItemChanged: (int value) {
                                  print(value);
                                  setState(() {
                                    _selectedValue = value;
                                  });
                                },
                              ),
                            ));
                  },
                ),

                SizedBox(height: 0),
                // Step 9
                Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalVariables.primaryColor),
                        onPressed: () {
                          print("pressed");
                          controller.start();
                        },
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // Step 10
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalVariables.primaryColor),
                        onPressed: () {
                          if (countdownTimer == null ||
                              countdownTimer!.isActive) {
                            stopTimer();
                          }
                        },
                        child: Icon(
                          Icons.stop,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // Step 11
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: GlobalVariables.primaryColor),
                          onPressed: () {
                            resetTimer();
                          },
                          child: Icon(
                            Icons.restore,
                            color: Colors.white,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: planWidth * 0.9,
            alignment: Alignment.centerLeft,
            child: Text(
              "Task :" + widget.task.task_name,
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 23),
            ),
          ),
          Center(
            child: Container(
              height: 350,
              child: ListView.builder(
                  itemCount: subtasks.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      MainPageCatTile.greenPageTileSubTask(
                          Container(
                              width: planWidth * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Row(
                                  children: [
                                    Radio(
                                        activeColor: Colors.white,
                                        value: subtasks[index].task_id,
                                        groupValue: "",
                                        onChanged: (value) {
                                          completeTask(
                                            subtasks[index].task_id,
                                          );
                                        }),
                                    Container(
                                      child: Text(
                                        subtasks[index].sub_label ?? '',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          planWidth * 0.9)
                    ]);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
