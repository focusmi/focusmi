// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focusmi/features/pomodoro_timer/services/pomodoro_timer_services.dart';
import 'package:focusmi/features/pomodoro_timer/widgets/count_down_timer_2.dart';
import 'package:focusmi/models/daily_tips.dart';
import 'package:story_view/story_view.dart';
import 'package:focusmi/constants/global_variables.dart';

import 'package:focusmi/features/group_task_planner/screens/single_task_view.dart';
import 'package:focusmi/features/pomodoro_timer/widgets/countdown_timer.dart';
import 'package:focusmi/models/task.dart';

class BreakView extends StatefulWidget {
  static const String routeName = '/break_view';
  final Task task;
  final int btime;
  const BreakView({
    Key? key,
    required this.task,
    required this.btime,
  }) : super(key: key);
  @override
  State<BreakView> createState() => _BreakViewState();
}

class _BreakViewState extends State<BreakView> {
  final StoryController controller = StoryController();
  late List<DailyTips> tips;
  late List<StoryItem> items = List<StoryItem>.empty(growable: true);
  @override
  void initState() {
    Timer(Duration(seconds: widget.btime * 60), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SingleTaskView(
                    task: widget.task,
                  )));
    });

    refreshTips('saturday');
    super.initState();
  }

  void refreshTips(day) async {
    try {
      var result = await PomodoroTimerServices.getTipsByDay(day);
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      setState(() {
        tips = list.map((model) => DailyTips.fromJson(model)).toList();
        for (DailyTips element in tips) {
          items.add(StoryItem.inlineImage(
                      url:'$uri/api/assets/image/mind-course/${element.content_location}',
                      controller: controller,
                      caption: Text(
                        element.text??'',
                        style: TextStyle(
                          color: Colors.white,

                          fontSize: 17,
                        ),
                      ),
                    ));
          // items.add(
          //    StoryItem.text(
          //               title:
          //                   element.content_location??'fgf',
          //               backgroundColor: Colors.orange,
          //               roundedTop: true,
          //             ),
          // );
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(
            8,
          ),
          child: ListView(
            children: <Widget>[
              Container(
                height: 800,
                child: StoryView(
                  controller: controller,
                  storyItems:
                      //[
                      // StoryItem.text(
                      //   title:
                      //       "Hello world!\nHave a look at some great Ghanaian delicacies. I'm sorry if your mouth waters. \n\nTap!",
                      //   backgroundColor: Colors.orange,
                      //   roundedTop: true,
                      // ),
                      // StoryItem.inlineImage(
                      //   NetworkImage(
                      //       "https://image.ibb.co/gCZFbx/Banku-and-tilapia.jpg"),
                      //   caption: Text(
                      //     "Banku & Tilapia. The food to keep you charged whole day.\n#1 Local food.",
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       backgroundColor: Colors.black54,
                      //       fontSize: 17,
                      //     ),
                      //   ),
                      // ),
                      // StoryItem.inlineImage(
                      //   url:
                      //       "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
                      //   controller: controller,
                      //   caption: Text(
                      //     "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       backgroundColor: Colors.black54,
                      //       fontSize: 17,
                      //     ),
                      //   ),
                      // ),
                      //  ],
                      items,
                  onStoryShow: (s) {
                    print("Showing a story");
                  },
                  onComplete: () {
                    print("Completed a cycle");
                  },
                  progressPosition: ProgressPosition.bottom,
                  repeat: false,
                  inline: true,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MoreStories()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(8))),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "View more stories",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 500,
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: TextualCTimer(minutes: widget.btime)),
          ],
        )
      ],
    );
  }
}

class MoreStories extends StatefulWidget {
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
      ),
      body: StoryView(
        storyItems: [
          StoryItem.text(
            title: "I guess you'd love to see more of our food. That's great.",
            backgroundColor: Colors.blue,
          ),
          StoryItem.text(
            title: "Nice!\n\nTap to continue.",
            backgroundColor: Colors.red,
            textStyle: TextStyle(
              fontFamily: 'Dancing',
              fontSize: 40,
            ),
          ),
          StoryItem.pageImage(
            url:
                "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
            caption: "Still sampling",
            controller: storyController,
          ),
          StoryItem.pageImage(
              url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
              caption: "Working with gifs",
              controller: storyController),
          StoryItem.pageImage(
            url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
            caption: "Hello, from the other side",
            controller: storyController,
          ),
          StoryItem.pageImage(
            url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
            caption: "Hello, from the other side2",
            controller: storyController,
          ),
        ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}
