// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';

class TextualCTimer extends StatefulWidget {
  final int minutes;
  const TextualCTimer({
    Key? key,
    required this.minutes,
  }) : super(key: key);

  @override
  State<TextualCTimer> createState() => _TextualCTimerState();
}

class _TextualCTimerState extends State<TextualCTimer> {
  Timer? countdownTimer;
  Duration myDuration = Duration(days: 5);
  @override
  void initState() {
    startTimer();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(0);
    final minutes = strDigits(myDuration.inMinutes.remainder(widget.minutes));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          // Step 8
          Text(
            '$minutes:$seconds',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 255, 255, 255), fontSize: 50),
          ),
          SizedBox(height: 20),
          // Step 9
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.primaryColor
                ),
                onPressed: startTimer,
                child: Text(
                  'Start',

                  style: TextStyle(
                    fontSize: 25,
                    color:Colors.white
                  ),
                ),
              ),
              // Step 10
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.primaryColor
                ),
                onPressed: () {
                  if (countdownTimer == null || countdownTimer!.isActive) {
                    stopTimer();
                  }
                },
                child: Text(
                  'Stop',
                  style: TextStyle(
                    fontSize: 25,
                    color:Colors.white
                  ),
                ),
              ),
              // Step 11
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.primaryColor
                ),
                  onPressed: () {
                    resetTimer();
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 25,
                      color:Colors.white
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}


  // Step 2
