import 'package:therapist_app/features/therapist/screen/available_Schedule_Screen.dart';
import 'package:flutter/material.dart';
import 'package:therapist_app/features/therapist/screen/upcomming_schedule_screen.dart';

import '../../../constants/global_variables.dart';

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
    UpcomingScheduleScreen(),
    Container(),
    // Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController, // Add the scroll controller here
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _showFlexibleSpaceTitle ? Colors.white : Colors.black,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  // Handle more options button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AvailableSchedulePage(),
                    ),
                  );
                },
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F6FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _buttonIndex = 0;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 25),
                                decoration: BoxDecoration(
                                  color: _buttonIndex == 0
                                      ? const Color(0xff83de70)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
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
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _buttonIndex = 1;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 25),
                            decoration: BoxDecoration(
                              color: _buttonIndex == 1
                                  ? const Color(0xff83de70)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Widgets According to buttons
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
