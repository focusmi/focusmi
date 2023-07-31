import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:therapist_app/common/widgets/schedule_card.dart';
import 'package:therapist_app/features/schedule/service/scheduleservice.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../provider/user_provider.dart';

class CompletedScheduleScreen extends StatefulWidget {
  @override
  _CompletedScheduleScreenState createState() =>
      _CompletedScheduleScreenState();
}

class _CompletedScheduleScreenState extends State<CompletedScheduleScreen> {
  List<dynamic> scheduleData = [];

  @override
  void initState() {
    super.initState();
    fetchScheduleData();
  }

  String formatAppointmentDateTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('yyyy-MM-dd').format(dateTime) +
        ', ' +
        DateFormat('hh:mm a').format(dateTime);
  }

  Future<void> fetchScheduleData() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;
      List<dynamic> data =
          await ScheduleService.getScheduleDataForUser(user.id, user.token);
      setState(() {
        scheduleData = data;
      });
    } catch (e) {
      print('Error fetching schedule data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Appointments",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          if (scheduleData.isNotEmpty)
            Center(
              child: Container(
                  height: 200,
                  margin: const EdgeInsets.only(top: 100),
                  child: Lottie.asset('assets/images/Comp.json',
                      fit: BoxFit.cover)),
            )
          else
            Column(
              children: scheduleData.map((schedule) {
                return ScheduleCard(
                  patientName: schedule['patient_name'],
                  appointmentDate: formatAppointmentDateTime(
                      schedule['appointment_datetime']),
                  // appointmentTime: schedule['appointment_time'],
                  // status: schedule['status'],
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}