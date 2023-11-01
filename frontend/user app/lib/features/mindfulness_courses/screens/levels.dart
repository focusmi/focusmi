// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/mindfulness_courses/screens/course_content.dart';
import 'package:focusmi/features/mindfulness_courses/screens/course_media_player.dart';
import 'package:focusmi/features/mindfulness_courses/screens/flutter_flow/flutter_flow_theme.dart';
import 'package:focusmi/features/mindfulness_courses/services/mindfulness_main_page_services.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/course_level.dart';
import 'package:focusmi/models/mindfulnesscourses.dart';
import 'package:focusmi/widgets/containers.dart';
import 'package:just_audio/just_audio.dart';

class LevelsWidget extends StatefulWidget {
  static const String routeName = "levels";
  MindfulnessCourse course;

  LevelsWidget({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  _LevelsWidgetState createState() => _LevelsWidgetState();
}

class _LevelsWidgetState extends State<LevelsWidget> {
  late List<MindfulnessCourseLevel> levels;
  late List<String> durations;

  void getDurations() async {
    AudioPlayer player = AudioPlayer();
    try {
      print("///");
      print(levels);
      for (MindfulnessCourseLevel element in levels) {
        print("iiiiiiiiiiiiiiiiiiiiiiiii");
        player.setUrl(
            '$uri/api/assets/image/mind-course/${element.content_location}');
        print(player.duration);
      }
    } catch (e) {
      print(e);
    }
  }

  void getCourseLevel() async {
    try {
      var result =
          await MindFMainPageServices.getCourseLevels(widget.course.course_id);
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      setState(() {
        levels = list
            .map((model) => MindfulnessCourseLevel.fromJson(model))
            .toList();
      });
      AudioPlayer player = AudioPlayer();
      for (MindfulnessCourseLevel element in levels) {
        Duration? durationstr = await player.setUrl(
            '$uri/api/assets/image/mind-course/${element.content_location}');

        setState(() {
          durations.add(durationstr.toString().split(':')[1] +
              ":" +
              durationstr.toString().split(':')[2]);
        });
      }
      print("--------");
      print(result.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    levels = [];
    getCourseLevel();
    durations = [];
    getDurations();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LayOut layOut = LayOut();
    return ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, CourseMediaPlayer.routeName,
                  arguments: [levels[index], widget.course]);
            },
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                CustomContainer.normalContainer(
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(children: [
                           Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: Icon(
                                  Icons.play_circle_outlined,
                                  size: 40,
                                )),
                                Text(
                                  durations[index].split('.')[0],
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, CourseMediaPlayer.routeName,
                                  arguments: [levels[index], widget.course]);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                        levels[index].level_name?.trim() ??
                                            '',style: TextStyle(
                                              fontSize: 17,
                                              fontWeight:FontWeight.bold,
                                              color: GlobalVariables.greyFontColor
                                            ),)),
                                Text(((levels[index].level_description ?? '') +
                                        '......') ??
                                    '',style: TextStyle(color: GlobalVariables.greyFontColor),),
                              ],
                            ),
                          ),
                          
                         
                        ]),
                      ),
                    ),
                    80,
                    MediaQuery.of(context).size.width * 0.8),
              ],
            ),
          );
        });
  }
}

class LevelCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const LevelCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          {Navigator.pushNamed(context, CourseContentWidget.routeName)},
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: GlobalVariables.backgroundColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FlutterFlowTheme.of(context).title1.override(
                          fontFamily: 'Readex Pro',
                        ),
                  ),
                  Text(
                    subtitle,
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
