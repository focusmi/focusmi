// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/mindfulness_courses/screens/flutter_flow/flutter_flow_icon_button.dart';
import 'package:focusmi/features/mindfulness_courses/screens/flutter_flow/flutter_flow_theme.dart';
import 'package:focusmi/features/mindfulness_courses/screens/levels.dart';
import 'package:focusmi/features/mindfulness_courses/services/mindfulness_main_page_services.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/mindfulnesscourses.dart';
import 'package:focusmi/widgets/texts.dart';

class CourseContentWidget extends StatefulWidget {
  static const String routeName = '/course_content';

  final MindfulnessCourse course;

  const CourseContentWidget({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  _CourseContentWidgetState createState() => _CourseContentWidgetState();
}

class _CourseContentWidgetState extends State<CourseContentWidget> {
  late List<Widget> items;
  late int pressed;
  @override
  void initState() {
    // TODO: implement initState
    items = [];
    pressed = 0;
    refreshSCourses();
    super.initState();
  }

  void refreshSCourses() async {
    try {
      var result = await MindFMainPageServices.getSimilarContent(
          widget.course?.course_type);
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      var temp =
          list.map((model) => MindfulnessCourse.fromJson(model)).toList();
      temp.removeWhere(
          (element) => element.course_id == widget.course?.course_id);
      setState(() {
        items = temp
            .map(
              (model) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CourseContentWidget.routeName,
                      arguments: model);
                  print(model.title);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    '$uri/api/assets/image/mind-course/${model.image}',
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
            .toList();
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();
    return layout.mainLayoutPage(SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              // child: Image.network(
              //   '$uri/api/assets/image/mind-course/${widget.course?.image}',
              //   width: MediaQuery.of(context).size.width,
              //   height: 250,
              //   fit: BoxFit.cover,
              // ),
              child: ClipPath(
                clipper: ConvexBottomClipper(),
                child: Image.network(
                  '$uri/api/assets/image/mind-course/${widget.course?.image}',
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  Container(
                    child: Icon(Icons.favorite_border,
                        size: 50, color: GlobalVariables.greyFontColor),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pressed = 1;
                      });
                    
                    },
                    child: Container(
                      child: Icon(Icons.play_arrow,
                          size: 60, color: GlobalVariables.greyFontColor),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Container(
                    child: Icon(Icons.done_all,
                        size: 55, color: GlobalVariables.greyFontColor),
                  ),
                ],
              ),
            ),
            (pressed == 0)
                ? Column(children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '${widget.course?.title?.trim()}',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: GlobalVariables.greyFontColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${widget.course?.description}',
                          textAlign: TextAlign.start,
                          style:
                              TextStyle(color: GlobalVariables.greyFontColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Similar Content',
                          style: TextStyle(
                              fontSize: 20,
                              color: GlobalVariables.greyFontColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        child: CarouselSlider(
                          items: items,
                          // items: [

                          //   ClipRRect(
                          //     borderRadius: BorderRadius.circular(8),
                          //     child: Image.network(
                          //       'https://picsum.photos/seed/42/600',
                          //       width: 300,
                          //       height: 200,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          //   ClipRRect(
                          //     borderRadius: BorderRadius.circular(8),
                          //     child: Image.network(
                          //       'https://picsum.photos/seed/923/600',
                          //       width: 300,
                          //       height: 200,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          //   ClipRRect(
                          //     borderRadius: BorderRadius.circular(8),
                          //     child: Image.network(
                          //       'https://picsum.photos/seed/462/600',
                          //       width: 300,
                          //       height: 200,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ],
                          options: CarouselOptions(
                              initialPage: 1,
                              viewportFraction: 1,
                              disableCenter: true,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.25,
                              enableInfiniteScroll: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 7)),
                        ),
                      ),
                    )
                  ])
                : Container(
                  height: 300,
                  child:LevelsWidget(course: widget.course)),
          ],
        ),
      ),
    ));
  }
}

class ConvexBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(
        0,
        size.height -
            30); // Start from the top left corner and reduce the Y-coordinate of the control point
    path.quadraticBezierTo(
        size.width / 2,
        size.height + 30,
        size.width,
        size.height -
            30); // Adjust the control point values to reduce the convex shape
    path.lineTo(size.width, 0); // Close the pate the path
    return path;
  }

  @override
  bool shouldReclip(oldClipper) {
    return false;
  }
}
