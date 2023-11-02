import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/appointment/services/appointment_service.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import 'conference/conference.dart';

class ViewAppointmentsWidget extends StatefulWidget {
  const ViewAppointmentsWidget({Key? key}) : super(key: key);
  static const String routeName = '/view_appointments';

  @override
  _ViewAppointmentsWidgetState createState() => _ViewAppointmentsWidgetState();
}

class _ViewAppointmentsWidgetState extends State<ViewAppointmentsWidget> {
  late List<dynamic> appointmentData = [];

  @override
  void initState() {
    super.initState();
    fetchAppointmentData();
  }

  Future<void> fetchAppointmentData() async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      final data = await AppointmentService.getAppointments(user.user_id);
      setState(() {
        appointmentData = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  String formatAppointmentDate(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String formatAppointmentTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: GlobalVariables.backgroundColor,
        appBar: AppBar(
          backgroundColor: const Color(0xFF83DE70),
          automaticallyImplyLeading: false,
          title: Text(
            'Your Appointments',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: appointmentData.length,
              itemBuilder: (context, index) {
                var appointment = appointmentData[index];
                return AppointmentCard(
                  fee: appointment['fee'],
                  time: appointment['session_time'],
                  date: formatAppointmentDate(appointment['session_time']),
                  starttime: formatAppointmentTime(appointment['session_time']),
                  endtime:
                      formatAppointmentTime(appointment['session_end_time']),
                  name: appointment['full_name'],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String time;
  final String endtime;
  final String date;
  final String starttime;
  final int fee;
  final String name;

  AppointmentCard({
    required this.time,
    required this.date,
    required this.endtime,
    required this.starttime,
    required this.fee,
    required this.name,
  });

  compareWithCurrentTime(String appointmentDateStr) {
    DateTime appointmentDate = DateTime.parse(appointmentDateStr).toLocal();

    DateTime now = DateTime.now();

    if (appointmentDate.isBefore(now)) {
      return "Appointment Time Passed";
    } else if (appointmentDate.isAfter(now)) {
      return "Waiting";
    } else {
      return "Join";
    }
  }

  compareTime(String appointmentDateStr) {
    DateTime appointmentDate = DateTime.parse(appointmentDateStr).toLocal();

    DateTime now = DateTime.now();

    if (appointmentDate.isBefore(now)) {
      return true;
    } else {
      return false;
    }
  }

  void jumpToMeetingPage(BuildContext context,
      {required String conferenceId,
      required String userName,
      required String userId}) {
    // Navigator.push(
    //   context,
    //   PageTransition(
    //       type: PageTransitionType.topToBottom,
    //       child: VideoConferencePage(
    //         conferenceID: conferenceId,
    //         userName: userName,
    //         userId: userId,
    //       )),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Councillor: Dr.${name}",
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Date: ${date}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Start Time:${starttime}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'END Time:${endtime}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Fees:${fee}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  if (compareWithCurrentTime(time) != 'Waiting') {
                    var user =
                        Provider.of<UserProvider>(context, listen: false).user;
                    jumpToMeetingPage(
                      context,
                      conferenceId: '6465904131',
                      userName: user.username,
                      userId: '${(user.user_id)+2}',
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please Wait ...'),
                      backgroundColor: Colors.red,
                    ));
                  }
                  print('Button pressed ...');
                },
                child: Text(
                  '${compareWithCurrentTime(time)}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    GlobalVariables.primaryColor,
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(300, 50), // Set the width and height of the button
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

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Appointment App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ViewAppointmentsWidget(),
      ),
    ),
  );
}
