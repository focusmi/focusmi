import 'dart:convert';
import 'dart:ui';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:focusmi/features/appointment/screens/view_appointments.dart';
import 'package:focusmi/features/authentication/screens/auth_screen.dart';
import 'package:focusmi/features/authentication/screens/packages_page.dart';
import 'package:focusmi/features/group_task_planner/screens/task_plan_view.dart';
import 'package:focusmi/features/group_task_planner/services/group_task_planner_services.dart';
import 'package:focusmi/features/individual_task_planner/screens/itask_plan_view.dart';
import 'package:focusmi/features/mainpage/screens/notification_page.dart';
import 'package:focusmi/features/mainpage/services/main_page_services.dart';
import 'package:focusmi/features/mainpage/services/noti_services.dart';
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
  List<Notifications> characterList = List<Notifications>.empty();
  late String package;

  List<String> images = [
    "med.jpg",
    "stress.jpg",
    "sleepwell.jpg",
    "focus.jpg",
    "relationship.jpg",
    "applied.jpg"
  ];
  List<String> pageNames = [
    "meditation",
    "stress relief",
    "sleep well",
    "focus",
    "relationship",
    "applied mindfulness"
  ];
  List<String> name = [
    "Meditation",
    "Stress Relief",
    "Sleep Well",
    "Focus",
    "Relationship",
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

  void getUserPackage() async {
    try {
      var result = await MindFMainPageServices.getUserPackage(context);
      var val = json.decode(result.body)[0]['account_status'];
      setState(() {
        package = val;
      });
    } catch (e) {}
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
    } catch (e) {
      print(e);
    }
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

  void getNotifromApi() async {
    var response = await NotiServices.getNotification(context);
    setState(() {
      try {
        Iterable list =
            json.decode(response.body).cast<Map<String?, dynamic>>();
        characterList =
            list.map((model) => Notifications.fromJson(model)).toList();
      } catch (e) {}
      print("dfdfd");
      print(characterList.length);
    });
  }

  @override
  void initState() {
    taskPlan = List<TaskPlan>.empty(growable: true);
    blogs = List<Blog>.empty(growable: true);
    therapists = [];
    featuredCourse = [];
    bval = 0;
    package = 'free';
    getUserPackage();
    getNotifromApi();
    getTaskPlanApi();
    getFeatured();
    getTherapist();

    notification = Notifications();
    isNoti = false;
    controller.addListener(onScroll);
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (characterList.length != 0)
        ElegantNotification.success(
                animation: AnimationType.fromTop,
                notificationPosition: NotificationPosition.topCenter,
                toastDuration: Duration(seconds: 10),
                title: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, NotiList.routeName);
                    },
                    child: Container(
                        child: Text(
                            "You have ${characterList.length} notifcation"))),
                description: Text(notification.text ?? ''))
            .show(context);
    });
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
                      SizedBox(
                        height: 250,
                      ),
                      // GestureDetector(
                      //   onTap: () {

                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      //     child: Container(
                      //       alignment: Alignment.centerRight,
                      //       child: Icon(
                      //         Icons.email,
                      //         color: const Color.fromARGB(255, 255, 255, 255),
                      //         size: 50,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
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
                                GestureDetector(
                                    onTap: () {
                                      var user = Provider.of<UserProvider>(
                                              context,
                                              listen: false)
                                          .user;
                                      Navigator.pushNamed(
                                          context, ITaskPlanner.routeName,
                                          arguments: [user.user_id, null]);
                                    },
                                    child: MainPageCatTile.greenPageTile(
                                        "        Task Planner",
                                        screenWidth * 0.45)),
                                SizedBox(
                                  width: 5,
                                  height: 0,
                                ),
                                GestureDetector(
                                  child: MainPageCatTile.greenPageTile(
                                      "        Task Groups",
                                      screenWidth * 0.45),
                                  onTap: () {
                                    // NotiServices.ShowNotification(id: 1,title: "fdfdf",body: "dfdfdf",payload: "dfdfdf");
                                    Navigator.pushNamed(
                                        context, GroupList.routeName);
                                  },
                                )
                              ],
                            ),
                            (package == 'free')
                                ? SizedBox(
                                    height: 20,
                                    width: 0,
                                  )
                                : SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                            (package == 'free')
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SubscriptionPackagesPage(),
                                          ));
                                    },
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                          width: width*0.95,
                                          height: 80,
                                           decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(image:AssetImage('assets/images/night.jpg'),fit:BoxFit.cover)
                                      ),
                                      child:Center(
                                        child: Text(
                                            "Be A Premium Member", style: TextStyle(
                                              color: Colors.white,fontSize: 20,
                                            ),),
                                      ),
                                    ),
                                  )
                                : (package=='freedom')?
                                
                                Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubscriptionPackagesPage(),
                                              ));
                                        },
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          width: width*0.95,
                                          height: 80,
                                           decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(image:AssetImage('assets/images/night.jpg'),fit:BoxFit.cover)
                                      ),
                                      child:Center(
                                        child: Text(
                                            "Be Free With Extra Freedom", style: TextStyle(
                                              color: Colors.white,fontSize: 20,
                                            ),),
                                      ),
                                        ),
                                      ),
                                  ],
                                )
                                :SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            (taskPlan.length!=0)?Container(
                              height: 40,
                              width: width,
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Recent Task Plans",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ):SizedBox(width: 0,height: 0,),
                            (taskPlan.length!=0)?Container(
                              alignment: Alignment.topLeft,
                              width: 500,
                              height: 180,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: taskPlan.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => {
                                        Navigator.pushNamed(
                                            context, GroupTaskPlanner.routeName,
                                            arguments: [
                                              taskPlan[index].group_id,
                                              taskPlan[index].plan_id
                                            ])
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: MainPageCatTile.greenPageTile(
                                            taskPlan[index].plan_name,
                                            width * 0.1),
                                      ),
                                    );
                                  }),
                            ):SizedBox(width: 0,height: 0,),
                            Container(
                              height: 40,
                              width: width,
                              alignment: Alignment.bottomLeft,
                              child: (package!='free')?Text(
                                "Featured Content",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ):Row(children: [
                                Text(
                                "Featured Content",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.lock,size: 30,color: Colors.white,)
                              ]),
                            ),
                            GestureDetector(
                              onTap: () {
                                (package!='free')?{
                                  Navigator.pushNamed(
                                      context, CourseContentWidget.routeName,
                                      arguments: featuredCourse[0])

                                }:(){};
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
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewAppointmentsWidget()),
                                      );
                                    },
                                    child: Text(
                                      "Meet Our Professionals",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                  ),

                                  // Text("Set Appointment Now",style: TextStyle(color: Colors.white),)
                                ],
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
                                                '$uri/api/assets/image/user-profs/${(therapists[index].image)?.split("images/")[1]}'),
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
                                        Navigator.pushNamed(
                                            context, CatLevelWidget.routeName,
                                            arguments: pageNames[index]);
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
                                          child: Container(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  name[index],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              )),
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
