import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/appointment/services/appointment_service.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ViewAppointmentsWidget extends StatefulWidget {
  const ViewAppointmentsWidget({Key? key}) : super(key: key);
  static const String routeName = '/view_appointments';

  @override
  _ViewAppointmentsWidgetState createState() => _ViewAppointmentsWidgetState();
}

class _ViewAppointmentsWidgetState extends State<ViewAppointmentsWidget> {
  late List<dynamic> appointmentData = [];
  late List<dynamic> moreData = [];
  late List<dynamic> councillorData = [];

  @override
  void initState() {
    super.initState();
    fetchAppointmentData();
  }

  compareWithCurrentTime(String appointmentDateStr) {
    DateTime appointmentDate = DateTime.parse(appointmentDateStr).toLocal();

    DateTime now = DateTime.now();

    if (appointmentDate.isBefore(now)) {
      return "Time Pasted";
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
    // //   PageTransition(
    // //       type: PageTransitionType.topToBottom,
    // //       child: VideoConferencePage(
    // //         conferenceID: conferenceId,
    // //         userName: userName,
    // //         userId: userId,
    // //       )),
    // );
  }

  Future<void> fetchAppointmentData() async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      print(user.user_id);
      final data = await AppointmentService.getAppointments(user.user_id);
      setState(() {
        appointmentData = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchMoreData(sessionId) async {
    try {
      final data = await AppointmentService.getAppointmentDetails(sessionId);
      setState(() {
        moreData = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchCouncillorData(userId) async {
    try {
      final data = await AppointmentService.getCouncillorDetails(userId);
      setState(() {
        councillorData = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
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
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (var appointment in appointmentData ?? [])
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        enableDrag: true,
                        showDragHandle: true,
                        context: context,
                        builder: (context) {
                          fetchMoreData(appointment['session_id']);
                          fetchCouncillorData(moreData[0]['user_id']);
                          String dateTimeString = moreData[0]['session_time'];
                          DateTime dateTime = DateTime.parse(dateTimeString)
                              .toLocal(); // Parse the string into DateTime object
                          String date =
                              '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
                          String time =
                              '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

                          String endDateTimeString =
                              moreData[0]['session_end_time'];
                          DateTime endDateTime =
                              DateTime.parse(endDateTimeString).toLocal();
                          String endtime =
                              '${endDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}';

                          return Container(
                            height: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Appointment Number:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${appointment['appointment_id']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Date :',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '$date',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Start Time :',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '$time',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'END Time :',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '$endtime',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Fees :',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${moreData[0]['fee']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Councillor:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Dr.${councillorData[0]['full_name']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (compareWithCurrentTime(
                                                    dateTimeString) !=
                                                'Waiting') {
                                              // jumpToMeetingPage(
                                              //   context,
                                              //   conferenceId:
                                              //       '${appointmentId * pow(10, 9)}',
                                              //   userName: user.name,
                                              //   userId: '${user.id}',
                                              // );
                                            } else {
                                              //showSnackBar(
                                              //  context, 'Please Waiting');
                                            }
                                            print('Button pressed ...');
                                          },
                                          child: Text(
                                            '${compareWithCurrentTime(dateTimeString)}',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              GlobalVariables.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: AppointmentCard(
                      appointmentNo: appointment['appointment_id'],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final int appointmentNo;
  AppointmentCard({
    required this.appointmentNo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 241, 254, 239),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: 10),
              Text(
                "Appointment No: $appointmentNo",
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
          ),
        ],
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
