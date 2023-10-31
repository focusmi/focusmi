import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/appointment/screens/conference/conference.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_theme.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_widgets.dart';
import 'package:focusmi/features/appointment/services/appointment_service.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'flutter_flow/flutter_flow_util.dart';

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
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.topToBottom,
          child: VideoConferencePage(
            conferenceID: conferenceId,
            userName: userName,
            userId: userId,
          )),
    );
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
            style: FlutterFlowTheme.of(context).bodyText1.override(
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
                            height: 300,
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                      Text(
                                        '${appointment['appointment_id']}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                      Text(
                                        '$date',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                      Text(
                                        '$time',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                      Text(
                                        '$endtime',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                      Text(
                                        '${moreData[0]['fee']}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                      Text(
                                        'Dr.${councillorData[0]['full_name']}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
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
                                        child: FFButtonWidget(
                                          onPressed: () {
                                            if (compareWithCurrentTime(
                                                    dateTimeString) !=
                                                'Waiting') {
                                              jumpToMeetingPage(
                                                context,
                                                conferenceId:
                                                    '1000000000',
                                                userName: 'user',
                                                userId: '1',
                                              );
                                            } else {
                                              //showSnackBar(
                                              //  context, 'Please Waiting');
                                            }
                                            print('Button pressed ...');
                                          },
                                          text:
                                              '${compareWithCurrentTime(dateTimeString)}',
                                          options: FFButtonOptions(
                                            height: 40,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 0, 24, 0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            color: GlobalVariables.primaryColor,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                    ),
                                            elevation: 3,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
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
                    "Appointment No: $appointmentNo",
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
            ),
          ],
        ),
      ),
    );
  }
}
