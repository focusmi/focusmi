import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:focusmi/features/group_task_planner/services/group_task_planner_services.dart';
import 'package:focusmi/features/mainpage/services/main_page_services.dart';
import 'package:focusmi/features/task_group.dart/screens/group_list.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/blog.dart';
import 'package:focusmi/models/taskplan.dart';
import 'package:focusmi/providers/user_provider.dart';
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

  @override
  void initState() {
    taskPlan = List<TaskPlan>.empty(growable: true);
    blogs = List<Blog>.empty(growable: true);
    getTaskPlanApi();
    getBlogs();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();
    double screenWidth = MediaQuery.of(context).size.width;
    final user = Provider.of<UserProvider>(context).user;
    return layout.mainLayout(Column(children: [
      Container(
        child: Column(children: [
          Row(
            children: [
              Container(child: Center(child: Text("Task Planner"))),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                child: Container(
                  child: Center(child: Text("Task Groups")),
                ),
                onTap: () {
                  Navigator.pushNamed(context, GroupList.routeName);
                },
              ),
            ],
          ),
          Row(
            children: [
              Container(child: Center(child: Text("Mindfulness Exercises"))),
              const SizedBox(
                width: 20,
              ),
              Container(
                child: Center(child: Text("Professionals")),
              )
            ],
          ),
          Container(
            width: 500,
            height: 100,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: taskPlan.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Text(taskPlan[index].plan_name),
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
                  return Container(child: Text(blogs[index].title));
                }),
          ),
        ]),
      ),
      Container(
          //task plans goes here
          ),
      Container(
          //mindfullness courses goes here
          )
    ]));
  }
}
