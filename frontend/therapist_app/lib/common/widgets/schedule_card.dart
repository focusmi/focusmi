import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/constants/util.dart';
import 'package:therapist_app/features/conference/conference.dart';
import 'package:therapist_app/features/schedule/service/scheduleservice.dart';
import 'package:therapist_app/provider/user_provider.dart';

class ScheduleCard extends StatelessWidget {
  final String patientName;
  final String appointmentTime;
  final String appointmentEndTime;
  final String status;
  final String appointmentEndDateTime;
  final bool complete;
  final int appointmentId;
  final Function() onAppointmentCompleted;

  ScheduleCard({
    required this.patientName,
    required this.appointmentTime,
    required this.appointmentEndTime,
    required this.status,
    required this.complete,
    required this.appointmentEndDateTime,
    required this.appointmentId,
    required this.onAppointmentCompleted,
  });

  compareWithCurrentTime(String appointmentDateStr) {
    DateFormat format = DateFormat("yyyy-MM-dd, hh:mm a");
    DateTime appointmentDate = format.parse(appointmentDateStr).toLocal();

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
    DateFormat format = DateFormat("yyyy-MM-dd, hh:mm a");
    DateTime appointmentDate = format.parse(appointmentDateStr).toLocal();

    DateTime now = DateTime.now();

    if (appointmentDate.isBefore(now)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        color: const Color.fromARGB(255, 243, 247, 248),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent, // Remove the divider line
            expansionTileTheme: ExpansionTileThemeData(),
          ),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color.fromARGB(255, 243, 247, 248),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      patientName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(), // This will create maximum space
                    Container(
                      // color: Color.fromARGB(255, 184, 232, 171),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2), // Set the desired background color
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: status == 'online'
                              ? const Color.fromARGB(255, 205, 242, 194)
                              : const Color.fromARGB(255, 241, 210, 208)),
                      child: Row(
                        children: [
                          Container(
                            width: 18.0,
                            height: 18.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: status == 'online'
                                  ? GlobalVariables.primarySwatch
                                  : Colors.red,
                              border: Border.all(
                                color: Colors.white,
                                width: 3.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          Text(
                            ' ${status} ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: status == 'online'
                                    ? GlobalVariables.primarySwatch
                                    : Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(
                  height: 15,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Color.fromARGB(255, 182, 181, 181),
                ),
                Row(
                  children: [
                    Text(
                      appointmentTime,
                      //  style: GoogleFonts.abel()
                    ),
                    const Text(' - '),
                    Text(
                      appointmentEndTime,
                      //  style: GoogleFonts.abel()
                    ),
                  ],
                ),
              ],
            ),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Column(
                  children: [
                    const Divider(
                      height: 5,
                      thickness: 1,
                      indent: 0,
                      endIndent: 50,
                      color: Color.fromARGB(255, 182, 181, 181),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5, top: 8, bottom: 8, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              // Handle reschedule appointment
                              if (compareWithCurrentTime(appointmentTime) !=
                                  'Waiting') {
                                jumpToMeetingPage(
                                  context,
                                  conferenceId: '${appointmentId * pow(10, 9)}',
                                  userName: user.name,
                                  userId: '${user.id}',
                                );
                              } else {
                                showSnackBar(context, 'Please Waiting');
                              }
                            },
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xff83de70),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  '${compareWithCurrentTime(appointmentTime)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Visibility(
                            visible: !complete &&
                                compareTime(appointmentEndDateTime),
                            child: GestureDetector(
                              onTap: () async {
                                try {
                                  final user = Provider.of<UserProvider>(
                                          context,
                                          listen: false)
                                      .user;
                                  final response =
                                      await ScheduleService.completeAppointment(
                                    appointmentId,
                                    user.token,
                                  );

                                  if (response.statusCode == 200) {
                                    onAppointmentCompleted();
                                    showSnackBar(context,
                                        'Appointment complete successfully');
                                    // Successfully completed the appointment, you can perform any necessary actions here
                                  } else {
                                    showSnackBar(context,
                                        'Failed to complete Appointment');
                                    // Handle error response from the backend
                                    // You can show a Snackbar or display an error message
                                  }
                                } catch (e) {
                                  // Handle exceptions that occurred during the request
                                  // You can show a Snackbar or display an error message
                                }
                              },
                              child: Container(
                                width: 120,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 217, 219, 222),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Complete",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}

class CompleteScheduleCard extends StatelessWidget {
  final String patientName;
  final String appointmentTime;
  final String appointmentEndTime;
  // final String status;
  // final String appointmentEndDateTime;
  final bool complete;
  // final int appointmentId;

  CompleteScheduleCard({
    required this.patientName,
    required this.appointmentTime,
    required this.appointmentEndTime,
    // required this.status,
    required this.complete,
    // required this.appointmentEndDateTime,
  });

  compareWithCurrentTime(String appointmentDateStr) {
    DateFormat format = DateFormat("yyyy-MM-dd, hh:mm a");
    DateTime appointmentDate = format.parse(appointmentDateStr);

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
    DateFormat format = DateFormat("yyyy-MM-dd, hh:mm a");
    DateTime appointmentDate = format.parse(appointmentDateStr);

    DateTime now = DateTime.now();

    if (appointmentDate.isBefore(now)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        color: const Color.fromARGB(255, 243, 247, 248),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent, // Remove the divider line
            expansionTileTheme: ExpansionTileThemeData(),
          ),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color.fromARGB(255, 243, 247, 248),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      patientName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      appointmentTime,
                    ),
                    const Text(' - '),
                    Text(
                      appointmentEndTime,
                      //  style: GoogleFonts.abel()
                    ),
                  ],
                ),
              ],
            ),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Column(
                  children: [
                    const Divider(
                      height: 5,
                      thickness: 1,
                      indent: 0,
                      endIndent: 50,
                      color: Color.fromARGB(255, 182, 181, 181),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5, top: 8, bottom: 8, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
