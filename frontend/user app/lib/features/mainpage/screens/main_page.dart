import 'package:flutter/material.dart';
import 'package:focusmi/features/mainpage/services/main_page_services.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main_page';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void getRecentPlanApi() {
    MainPageServices.getRecentTaskPlans();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecentPlanApi();
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
              Container(
                child: Center(child: Text("Task Groups")),
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
