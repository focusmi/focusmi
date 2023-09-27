import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/group_task_planner/screens/single_task_view.dart';
import 'package:focusmi/features/group_task_planner/services/group_task_planner_services.dart';
import 'package:focusmi/features/pomodoro_timer/services/pomodoro_timer_services.dart';
import 'package:focusmi/models/task.dart';
import 'package:focusmi/models/taskplan.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key, required this.taskPlan});
  final TaskPlan taskPlan;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  // Step 2
  Timer? countdownTimer;
  late List<Task> tasks;
  Duration myDuration = Duration(days: 5);
  late int hour;
  late int minute;
  @override
  void initState() {
    hour = 0;
    minute = 20;
    tasks = [];
    super.initState();
    refreshTaskAllocation();
    setTimers(context);
    getTasks();
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
          await GTaskPlannerServices.getTaskByPlan(widget.taskPlan.plan_id);
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      setState(() {
        tasks = list.map((model) => Task.fromJson(model)).toList();
      });
      print("----------");
      print(tasks);
    } catch (e) {
      print("error in getTask in countdown timer");
    }
  }

  void refreshTaskAllocation() async {
    tasks.forEach((element) async {
      //get the tasks
      var result = await GTaskPlannerServices.getTaskByPlan(element.plan_id);
      //run the loop to create the list
      Iterable list = json.decode(result.body).cast<Map<String, dynamic>>();
      tasks = list.map((model) => Task.fromJson(model)).toList();
      //assign the loop in the set state
      setState(() {
        tasks = tasks;
      });
    });
  }

  void completeTask(task_id) async {
    try {
      GTaskPlannerServices.setTaskAttr('status', task_id, 'completed');
      refreshTaskAllocation();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    late final hours;
    late final minutes;
    double planWidth = MediaQuery.of(context).size.width;

    if (hour == 0) {
      hours = strDigits(0);
    } else {
      hours = strDigits(myDuration.inHours.remainder(hour + 1));
    }
    if (hour == 0) {
      minutes = strDigits(0);
    } else {
      minutes = strDigits(myDuration.inMinutes.remainder(minute));
    }
    //final minutes = strDigits(myDuration.inMinutes.remainder(minute));

    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Container(
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                // Step 8
                Text(
                  '$hours:$minutes:$seconds',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 50),
                ),
                SizedBox(height: 20),
                // Step 9
                Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: startTimer,
                        child: Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      // Step 10
                      ElevatedButton(
                        onPressed: () {
                          if (countdownTimer == null || countdownTimer!.isActive) {
                            stopTimer();
                          }
                        },
                        child: Text(
                          'Stop',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      // Step 11
                      ElevatedButton(
                          onPressed: () {
                            resetTimer();
                          },
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Container(
              height: 250,
              child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Container(
                        width: planWidth,
                        constraints: const BoxConstraints(
                          minHeight: 70,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: GlobalVariables.textFieldBgColor),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, SingleTaskView.routeName,
                                  arguments: (tasks[index]));
                            },
                            child: Container(
                                width: planWidth,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: tasks[index].task_id,
                                          groupValue: "",
                                          onChanged: (value) {
                                            completeTask(
                                              tasks[index].task_id,
                                            );
                                          }),
                                      Container(
                                        child: Text(
                                          
                                              tasks[index].task_name,
                                          style: const TextStyle(
                                              color: GlobalVariables
                                                  .greyFontColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ));
                  }),
            ),
          )
        ],
      ),
    );
  }
}
