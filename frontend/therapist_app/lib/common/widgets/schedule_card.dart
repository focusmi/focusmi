import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:therapist_app/constants/util.dart';
import 'package:therapist_app/features/conference/conference.dart';
import 'package:therapist_app/provider/user_provider.dart';

class ScheduleCard extends StatelessWidget {
  final String patientName;
  final String appointmentDate;

  ScheduleCard({
    required this.patientName,
    required this.appointmentDate,
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
        color: Color.fromARGB(255, 243, 247, 248),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent, // Remove the divider line
            expansionTileTheme: ExpansionTileThemeData(),
          ),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Color.fromARGB(255, 243, 247, 248),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  appointmentDate,
                //  style: GoogleFonts.abel()
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        // Handle cancel appointment
                      },
                      child: Container(
                        width: 120,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 217, 219, 222),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
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
                    InkWell(
                      onTap: () {
                        // Handle reschedule appointment
                        if (compareWithCurrentTime(appointmentDate) !=
                            'Waiting') {
                          jumpToMeetingPage(
                            context,
                            conferenceId: '1000000000',
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
                            '${compareWithCurrentTime(appointmentDate)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
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
      ),
    );
  }

  void jumpToMeetingPage(BuildContext context,
      {required String conferenceId,
      required String userName,
      required String userId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VideoConferencePage(
                conferenceID: conferenceId,
                userName: userName,
                userId: userId,
              )),
    );
  }
}
