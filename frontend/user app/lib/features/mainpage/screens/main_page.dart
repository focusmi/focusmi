import 'dart:convert';
import 'dart:ui';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:focusmi/features/authentication/screens/auth_screen.dart';
import 'package:focusmi/features/group_task_planner/services/group_task_planner_services.dart';
import 'package:focusmi/features/mainpage/services/main_page_services.dart';
import 'package:focusmi/features/mainpage/widgets/category_tile.dart';
import 'package:focusmi/features/mindfulness_courses/screens/cat_courses.dart';
import 'package:focusmi/features/mindfulness_courses/screens/course_content.dart';
import 'package:focusmi/features/mindfulness_courses/screens/course_media_player.dart';
import 'package:focusmi/features/mindfulness_courses/screens/levels.dart';
import 'package:focusmi/features/mindfulness_courses/services/mindfulness_main_page_services.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/task_group.dart/screens/group_list.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/administrative_user.dart';
import 'package:focusmi/models/blog.dart';
import 'package:focusmi/models/mindfulnesscourses.dart';
import 'package:focusmi/models/notification.dart';
import 'package:focusmi/models/taskplan.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:focusmi/widgets/containers.dart';
import 'package:focusmi/widgets/texts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main_page';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<TaskPlan> taskPlan;
  late List<Blog> blogs;
  late double bval;
  late ScrollController controller = ScrollController();
  late List<MindfulnessCourse> featuredCourse;
  late List<AdministrativeUser> therapists;
  late bool isNoti;
  late Notifications notification;
  List<String> images = [
    "med.jpg",
    "stress.jpg",
    "Sleep Well",
    "Focus",
    "Realtionship",
    "Applied Mindfulness"
  ];
  List<String> pageNames = [
    "meditation",
    "stress relief",
    "sleep well",
    "focus",
    "realtionship",
    "applied mindfulness"
  ];
  List<String> name = [
    "Meditation",
    "Stress Relief",
    "Sleep Well",
    "Focus",
    "Realtionship",
    "Applied Mindfulness"
  ];
  void getTaskPlanApi() async {
    try {
      Response response = await GTaskPlannerServices.getRecentTaskPlan();
      Iterable list = json.decode(response.body).cast<Map<String?, dynamic>>();
      List<TaskPlan> result =
          list.map((model) => TaskPlan.fromJson(model)).toList();
      setState(() {
        if (result.length > 2) {
          result = result.sublist(0, 2);
        }
        taskPlan = result;
      });
    } catch (e) {
      print(e);
    }
  }

  void getBlogs() async {
    try {
      Response response = await MainPageServices.getBlogs();
      Iterable list = json.decode(response.body).cast<Map<String?, dynamic>>();
      List<Blog> result = list.map((model) => Blog.fromJson(model)).toList();
      setState(() {
        blogs = result;
      });
    } catch (e) {
      print(e);
    }
  }

  void getNotificatoin() async {
    try {
      var response = await MainPageServices.getNotfication(context);
      Iterable list = json.decode(response.body).cast<Map<String?, dynamic>>();
      List<Notifications> result =
          list.map((model) => Notifications.fromJson(model)).toList();
      if (json.decode(response.body)["noitem"] == false) {
        setState(() {
          isNoti = true;
          notification = result[0];
        });
      }
    } catch (e) {}
  }

  void onScroll() {
    setState(() {
      bval = controller.offset / 100;
    });
  }

  void getFeatured() async {
    try {
      var result = await MainPageServices.getCoursesFeatured();
      setState(() {
        Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
        featuredCourse =
            list.map((model) => MindfulnessCourse.fromJson(model)).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  void getTherapist() async {
    try {
      var result = await MindFMainPageServices.getTherapists();
      Iterable list = json.decode(result.body).cast<Map<String?, dynamic>>();
      therapists =
          list.map((model) => AdministrativeUser.fromJson(model)).toList();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    taskPlan = List<TaskPlan>.empty(growable: true);
    blogs = List<Blog>.empty(growable: true);
    therapists = [];
    featuredCourse = [];
    bval = 0;
    getTaskPlanApi();
    getFeatured();
    getTherapist();
    notification = Notifications();
    isNoti = false;
    controller.addListener(onScroll);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();
    final width = MediaQuery.of(context).size.width;
    double screenWidth = MediaQuery.of(context).size.width;
    final user = Provider.of<UserProvider>(context).user;
    return layout.mainLayoutPage(Stack(
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                  height: 400,
                  child: Expanded(
                      child: Image.asset(
                    'assets/images/wal.png',
                    fit: BoxFit.fitHeight,
                  ))),
              Container(
                  child: Expanded(
                      child: Image.asset(
                'assets/images/down.png',
                fit: BoxFit.fitHeight,
              ))),
            ],
          ),
        ),
        ClipRRect(
          // Clip it cleanly.
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: bval, sigmaY: bval),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              alignment: Alignment.center,
              child: Container(
                width: 500,
                child: SingleChildScrollView(
                  controller: controller,
                  child: Container(
                    child: Column(children: [
                      GestureDetector(
                        onTap: () {
                          ElegantNotification.success(
                                  title: Text(notification.type ?? ''),
                                  description: Text(notification.text ?? ''))
                              .show(context);
                        },
                        child: Container(
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          child: Column(children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.005,
                                ),
                                MainPageCatTile.greenPageTile(
                                    "        Task Planner", screenWidth * 0.45),
                                SizedBox(
                                  width: 5,
                                  height: 0,
                                ),
                                GestureDetector(
                                  child: MainPageCatTile.greenPageTile(
                                      "        Task Groups",
                                      screenWidth * 0.45),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, GroupList.routeName);
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                              width: 0,
                            ),
                            Container(
                              height: 40,
                              width: width,
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Recent Task Plans",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width: 500,
                              height: 180,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: taskPlan.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: MainPageCatTile.greenPageTile(
                                          taskPlan[index].plan_name,
                                          width * 0.1),
                                    );
                                  }),
                            ),
                            Container(
                              height: 40,
                              width: width,
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Featured Content",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CourseContentWidget.routeName,
                                    arguments: featuredCourse[0]);
                              },
                              child: Container(
                                // decoration: BoxDecoration(
                                // border: Border.all(color: Colors.white)
                                //),
                                width: width * 0.9,
                                height: 270,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: featuredCourse.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                          width: width * 0.9,
                                          height: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      '$uri/api/assets/image/mind-course/${featuredCourse[index].image}'),
                                                  fit: BoxFit.cover)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Container(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                featuredCourse[index].title ??
                                                    '',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 23),
                                              ),
                                            ),
                                          ));
                                    }),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: width,
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Meet Our Professionals",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                            Container(
                              height: 120,
                              child: ListView.builder(
                                  itemCount: therapists.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 40, //radius of avatar
                                            backgroundColor:
                                                Colors.green, //color
                                            backgroundImage: NetworkImage(
                                                '$uri/api/assets/image/user-profs/${therapists[index].image}'),
                                          ),
                                          Text(
                                            therapists[index].full_name ?? '',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 40,
                              width: width,
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                children: [
                                  Text(
                                    "Practice Mindfulness",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              child: ListView.builder(
                                  itemCount: images.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, CatLevelWidget.routeName,arguments: pageNames[index]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.43,
                                          height: 70,
                                          decoration: BoxDecoration(
                                         
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      '$uri/api/assets/image/mind-course/${images[index]}'),
                                                  fit: BoxFit.cover)),
                                          child: Text(name[index]),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ]),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
