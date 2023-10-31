import 'package:flutter/material.dart';
import 'package:focusmi/features/mindfulness_courses/services/mindfulness_main_page_services.dart';
import 'package:focusmi/models/mindfulnesscourses.dart';

class CourseMainPage extends StatefulWidget {
  const CourseMainPage({super.key});

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  late List<MindfulnessCourse> forYouCourses;
  late MindfulnessCourse? onGoingCourse;
  late MindfulnessCourse? meditation;
  late List<MindfulnessCourse> featuredCourses;
  late List<MindfulnessCourse> courses;

  refreshFeaturedCourses() async {
    try {
      var result = await MindFMainPageServices.getFeaturedContent();
      setState(() {
        featuredCourses = result;
      });
    } catch (e) {
      print("Error-refreshFeaturedCOurses");
      print(e);
    }
  }

  refreshMeditationCourses() async {
    try {
      var result = await MindFMainPageServices.getMeditationContent();
      setState(() {
        meditation = result;
      });
    } catch (e) {
      print("Error- meditation content");
      print(e);
    }
  }

  refreshOngoingContent() async {
    try {
      var result = await MindFMainPageServices.getOnGoingContent();
      setState(() {
        meditation = result;
      });
    } catch (e) {
      print("Error- on going content");
      print(e);
    }
  }

  refresForYouContent() async {
    try {
      var result = await MindFMainPageServices.getForYouContent();
      setState(() {
        meditation = result;
      });
    } catch (e) {
      print("Error- for you content");
      print(e);
    }
  }

  @override
  void initState() {
    forYouCourses = [];
    onGoingCourse = null;
    meditation = null;
    featuredCourses = [];

    // TODO: implement initState
    refreshOngoingContent();
    refreshFeaturedCourses();
    refresForYouContent();
    refreshMeditationCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
