import 'package:flutter/material.dart';
import 'package:therapist_app/features/schedule/screen/completed_schedule_screen.dart';
import '../../../constants/global_variables.dart';
import 'upcomming_schedule_screen.dart';

class ScheduleScreen extends StatefulWidget {
  static String routeName = "/schedule";

  ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _buttonIndex = 0;
  ScrollController _scrollController = ScrollController();
  bool _showFlexibleSpaceTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateFlexibleSpaceTitleVisibility);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateFlexibleSpaceTitleVisibility);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateFlexibleSpaceTitleVisibility() {
    setState(() {
      _showFlexibleSpaceTitle = _scrollController.hasClients &&
          _scrollController.offset >= (kToolbarHeight - kToolbarHeight / 4);
    });
  }

  final _scheduleWidgets = [
    UpcomingScheduleScreen(),
    CompletedScheduleScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 90,
            backgroundColor: _showFlexibleSpaceTitle
                ? GlobalVariables.primaryText
                : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Schedule",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _showFlexibleSpaceTitle ? Colors.white : Colors.black,
                ),
              ),
            ),
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.more_vert),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => SetTimeScheduleScreen(),
            //         ),
            //       );
            //     },
            //   ),
            // ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(90, 199, 233, 201),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _buttonIndex = 0;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 25,
                                ),
                                decoration: BoxDecoration(
                                  color: _buttonIndex == 0
                                      ? const Color(0xff83de70)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    "Upcoming",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: _buttonIndex == 0
                                          ? Colors.white
                                          : Colors.black38,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _buttonIndex = 1;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 25,
                                ),
                                decoration: BoxDecoration(
                                  color: _buttonIndex == 1
                                      ? const Color(0xff83de70)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    "Completed",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: _buttonIndex == 1
                                          ? Colors.white
                                          : Colors.black38,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Display the selected widget based on the _buttonIndex
                  _scheduleWidgets[_buttonIndex],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
