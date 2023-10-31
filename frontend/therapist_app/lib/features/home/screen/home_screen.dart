import 'package:lottie/lottie.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/features/blog/screen/blog_screen.dart';
import 'package:therapist_app/features/blog/screen/create_blog_screen.dart';
import 'package:therapist_app/features/home/screen/charts.dart';
import 'package:therapist_app/features/home/service/homeService.dart';
import 'package:therapist_app/features/profile/screen/profile_detail_screen.dart';
import 'package:therapist_app/features/schedule/screen/schedule_screen.dart';
import 'package:therapist_app/features/schedule/screen/set_time_schedule_screen.dart';
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
  late String newCount = '';

  @override
  void initState() {
    super.initState();
    fetchCount();
  }

  fetchCount() async {
    try {
      String count = await HomeService.getScheduleCount(context: context);
      setState(() {
        newCount = count;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override

  Widget build(BuildContext context) {
    List<Widget> buttonContainers = [
      GestureDetector(
        onTap: () async {
             final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateBlog(),
                  ),
                );

                 if (result == true) {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogScreen(),
                  ),
                );
                }
        },
        child: Container(
          height: 100,
          width: 120,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 236, 236, 236),
                offset: Offset(0.0, 2.0),
                blurRadius: 4.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 80,
                  child: Lottie.asset(
                    'assets/images/3JYUHR2r2k.json',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Add Blog',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
         Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileDetailsPage(),
                  ),
                );
        },
        child: Container(
          height: 100,
          width: 120,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 236, 236, 236),
                offset: Offset(0.0, 2.0),
                blurRadius: 4.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 80,
                  child: Lottie.asset(
                    'assets/images/Animation - 1698730732018.json',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'My Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SetTimeScheduleScreen(),
                  ),
                );
        },
        child: Container(
          height: 100,
          width: 120,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 236, 236, 236),
                offset: Offset(0.0, 2.0),
                blurRadius: 4.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 80,
                  child: Lottie.asset(
                    'assets/images/Animation - 1698604941220.json',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Time Slots',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];

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
                        color: Color.fromARGB(255, 164, 249, 159),
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
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                'Total Upcoming Appointments',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'The total upcoming appointments. Helps you stay organized and manage your time effectively.',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CustomButton(
                                                text: 'Goto Appointment',
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ScheduleScreen(),
                                                      ));
                                                },
                                              ),
                                            ),
                                          ],
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
                              '${newCount != '' ? newCount : '0'}',
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
                        color: Color.fromARGB(255, 164, 249, 159),
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
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                'Estimated available balance',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'The amount of funds in your account that you can currently use for transactions or withdrawals',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CustomButton(
                                                text: 'Got It',
                                                onTap: () {},
                                              ),
                                            ),
                                          ],
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
              padding: const EdgeInsets.only(left: 15, right: 10, top: 10),
              child: Text(
                "Time Slot Analyst",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 200,
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BarChartSample(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10, top: 10),
              child: Container(
                child: Text(
                  'Quick Access',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Container(
                height: 160,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 255, 243),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 236, 236, 236),
                        offset: Offset(0.0, 2.0), // Offset of the shadow
                        blurRadius: 4.0, // Blur radius
                        spreadRadius: 1.0, // Spread radius
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: buttonContainers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buttonContainers[index];
                    },
                  ),
                ),
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
  String greeth() {
    var hour = DateTime.now().hour;

    if (hour <= 12) {
      return 'Good Morning';
    } else if ((hour > 12) && (hour <= 16)) {
      return 'Good Afternoon';
    } else if ((hour > 16) && (hour < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  var greets = '';
  @override
  void initState() {
    greets = greeth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Row(
      children: [
        Container(
          height: 120,
          width: 120,
          child:
              Lottie.asset('assets/images/qO4KLdZrLb.json', fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${greets}",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "${user.name}",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
