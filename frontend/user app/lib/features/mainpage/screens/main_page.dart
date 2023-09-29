import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:focusmi/features/group_task_planner/services/group_task_planner_services.dart';
import 'package:focusmi/features/mainpage/services/main_page_services.dart';
import 'package:focusmi/features/mainpage/widgets/category_tile.dart';
import 'package:focusmi/features/task_group.dart/screens/group_list.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/blog.dart';
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
  void getTaskPlanApi() async {
    try {
      Response response = await GTaskPlannerServices.getRecentTaskPlan();
      Iterable list = json.decode(response.body).cast<Map<String?, dynamic>>();
      List<TaskPlan> result =
          list.map((model) => TaskPlan.fromJson(model)).toList();
      setState(() {
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

  void onScroll() {
    setState(() {
      bval = controller.offset / 100;
    });
  }

  @override
  void initState() {
    taskPlan = List<TaskPlan>.empty(growable: true);
    blogs = List<Blog>.empty(growable: true);
    bval = 0;
    getTaskPlanApi();
    getBlogs();

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
                      Container(),
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
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Recent Task Plans",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                            Container(
                              width: 500,
                              height: 500,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CustomContainer.normalContainer(
                                          CustomText.normalText(
                                              taskPlan[index].plan_name),
                                          70,
                                          width * 0.1),
                                    );
                                  }),
                            ),
                            Container(
                              width: 500,
                              height: 100,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: blogs.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        child: CustomText.normalText(
                                            blogs[index].title));
                                  }),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                          //task plans goes here

                          ),
                      Container(
                          //mindfullness courses goes here
                          )
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
