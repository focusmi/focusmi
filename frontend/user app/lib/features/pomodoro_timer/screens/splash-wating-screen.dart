// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:focusmi/features/pomodoro_timer/screens/break_view.dart';
import 'package:focusmi/models/task.dart';

class WaitingSplash extends StatefulWidget {
  final Task task;
  final int bduration;
  const WaitingSplash({
    Key? key,
    required this.task,
    required this.bduration,
  }) : super(key: key);

  @override
  State<WaitingSplash> createState() => _WaitingSplashState();
}

class _WaitingSplashState extends State<WaitingSplash> {
  late AudioPlayer player;
  @override
  void initState() {
    player = AudioPlayer();
    // TODO: implement in
    Future.delayed(Duration(seconds: 10), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BreakView(task: widget.task, btime: widget.bduration),
        ),
      );
    });
    loadMusic();
    playMusic();
    super.initState();
  }

  void loadMusic() async {
    try {
      await player.setUrl('$uri/api/assets/image/mind-course/bell.mp3');
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void playMusic() async {
    setState(() {});
    await player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/stars.jpg"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                child: LoadingAnimationWidget.hexagonDots(
                  color: Colors.white,
                  size: 200,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: SizedBox(
                  width: 250.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText('Take Breather',
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal)),
                        FadeAnimatedText('Your Break Starts Now',
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal)),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
