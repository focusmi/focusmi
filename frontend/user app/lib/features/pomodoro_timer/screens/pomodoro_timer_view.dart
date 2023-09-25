import 'package:flutter/material.dart';
import 'package:focusmi/features/pomodoro_timer/widgets/countdown_timer.dart';
import 'package:focusmi/layouts/pomodoro_timer_layout.dart';
import 'package:focusmi/models/taskplan.dart';

class PomodoroTimerScreen extends StatefulWidget {
  final TaskPlan taskplan;
  static const String routeName = '/pomodoro_timer_view';
  const PomodoroTimerScreen({super.key, required this.taskplan});

  @override
  State<PomodoroTimerScreen> createState() => _PomodoroTimerScreenState();
}

class _PomodoroTimerScreenState extends State<PomodoroTimerScreen> {
  @override
  Widget build(BuildContext context) {
    return PomodoroTimerLayout.mainLayout(
        CountdownTimer(taskPlan: widget.taskplan,), "Pomodoro Timer ", context);
  }
}
