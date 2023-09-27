import 'package:therapist_app/features/home/screen/charts.dart';
import 'package:therapist_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: UserInfo(),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    // color: Colors.orange.withAlpha(50),
                    height: 100,
                    width: 175,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 102, 255, 0).withAlpha(150),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 236, 236, 236),
                            offset: Offset(0.0, 2.0), // Offset of the shadow
                            blurRadius: 4.0, // Blur radius
                            spreadRadius: 1.0, // Spread radius
                          ),
                        ]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 8, bottom: 1),
                          child: Row(
                            children: [
                              Text(
                                "Appointments",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Show a BottomSheet when the GestureDetector is tapped
                                  showModalBottomSheet(
                                    enableDrag: true,
                                    showDragHandle: true,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 200,
                                        // color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'This is the bottom sheet 1',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.info_rounded,
                                  size: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "100",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 102, 255, 0).withAlpha(150),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 236, 236, 236),
                            offset: Offset(0.0, 2.0), // Offset of the shadow
                            blurRadius: 4.0, // Blur radius
                            spreadRadius: 1.0, // Spread radius
                          ),
                        ]),
                    height: 100,
                    width: 175,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 8, bottom: 1),
                          child: Row(
                            children: [
                              Text("Income LKR",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Show a BottomSheet when the GestureDetector is tapped
                                  showModalBottomSheet(
                                    enableDrag: true,
                                    showDragHandle: true,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 200,
                                        // color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            'This is the bottom sheet 2',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.info_rounded,
                                  size: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "15,000",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 200,
                decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 255, 216, 216),
                    ),
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BarChartSample(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PieChartSample2(),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Padding(
        padding: EdgeInsets.only(bottom: 7),
        child: Text("👋 Hello!"),
      ),
      subtitle: Text(
        "${user.name}",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
