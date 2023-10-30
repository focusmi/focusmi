// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/mindfulness_courses/screens/course_content.dart';
import 'package:focusmi/features/mindfulness_courses/screens/flutter_flow/flutter_flow_theme.dart';
import 'package:focusmi/features/mindfulness_courses/screens/levels.dart';
import 'package:focusmi/features/mindfulness_courses/services/mindfulness_main_page_services.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/mindfulnesscourses.dart';

class CatLevelWidget extends StatefulWidget {
  static const String routeName = '/cat_courses';
  String type;
  CatLevelWidget({
    Key? key,
    required this.type,
  }) : super(key: key);
  @override
  _CatLevelWidgetState createState() => _CatLevelWidgetState();
}

class _CatLevelWidgetState extends State<CatLevelWidget> {
  late List<MindfulnessCourse> courses;
  @override
  void initState() {
    // TODO: implement initState
    courses = [];
    refreshContent();
    super.initState();
  }

  void refreshContent() async {
    try {
      var result = await MindFMainPageServices.getSimilarContent(widget.type);
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      setState(() {
        courses =
            list.map((model) => MindfulnessCourse.fromJson(model)).toList();
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var layout = LayOut();
    return layout.mainLayoutWithDrawer(
        context,
        ListView.builder(
            shrinkWrap: true,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CourseContentWidget.routeName,arguments: courses[index]);
                },
                child: LevelCard(
                    imageUrl:
                        '$uri/api/assets/image/mind-course/${courses[index].image}' ??
                            '',
                    title: (courses[index].title ?? '').trim(),
                    subtitle: (((courses[index].description ?? '').substring(0,100))+"....").trim()),
              );
            }),
        widget.type);
  }
}

class LevelCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const LevelCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color.fromARGB(255, 255, 255, 255),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 406,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22
                  ),
                  
                ),
                Text(
                  subtitle,
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
