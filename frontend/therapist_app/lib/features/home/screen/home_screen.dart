import 'package:fl_chart/fl_chart.dart';
import 'package:therapist_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';

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
                  GestureDetector(
                    onTap: () {
                      print("Male");
                      setState(() {
                        // gender = "Male";
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      // color: Colors.orange.withAlpha(50),
                      height: 100,
                      width: 175,
                      decoration: BoxDecoration(
                          color:
                              Color.fromARGB(255, 102, 255, 0).withAlpha(150),
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.info_rounded,
                                  size: 15,
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
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      print("Female");
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color:
                              Color.fromARGB(255, 102, 255, 0).withAlpha(150),
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
                                Text("Total Clients",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.info_rounded,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "56",
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                  // BarChartSample(),
                  // BarChartSample(),
                  // BarChartSample(),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BarChartSample(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BarChartSample(),
                    ),
                  ),
                  ]
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

class BarChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 239, 251, 241)
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 12, // Adjust the maximum y-axis value as needed
                gridData: FlGridData(
                  show: false,
                ),
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: GlobalVariables.primaryText,
                    tooltipRoundedRadius: 10,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(showTitles: false),
                  rightTitles: SideTitles(showTitles: false),
                  topTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    margin: 10,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'Sun';
                        case 1:
                          return 'Mon';
                        case 2:
                          return 'Tue';
                        case 3:
                          return 'Wed';
                        case 4:
                          return 'Thu';
                        case 5:
                          return 'Fri';
                        case 6:
                          return 'Sat';
                        default:
                          return '';
                      }
                    },
                  ),
                ),
                borderData: FlBorderData(show: false),
                axisTitleData: FlAxisTitleData(show: false),
      
                barGroups: getBarGroups(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            y: 4, // Value for Sunday
            colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            y: 6, // Value for Monday
            colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            y: 8, // Value for Tuesday
           colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            y: 5, // Value for Wednesday
            colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            y: 9, // Value for Thursday
           colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            y: 7, // Value for Friday
            colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
            y: 3, // Value for Saturday
            colors: Color.fromARGB(255, 121, 235, 109)!= null ? [Color.fromARGB(255, 95, 204, 78)!] : null,
          ),
        ],
      ),
    ];
  }
}
