import 'package:flutter/material.dart';
import 'package:focusmi/layouts/pomodoro_timer_layout.dart';

class PomodoroTimerScreen extends StatefulWidget {
  const PomodoroTimerScreen({super.key});

  @override
  State<PomodoroTimerScreen> createState() => _PomodoroTimerScreenState();
}

class _PomodoroTimerScreenState extends State<PomodoroTimerScreen> {
  @override
  Widget build(BuildContext context) {
    return PomodoroTimerLayout.mainLayout(
      Column(
        children: [
          
        ],
      ) ,
      "Pomodoro Timer",
      context);
  }
}
