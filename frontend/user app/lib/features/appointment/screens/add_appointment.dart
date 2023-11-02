import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/appointment/screens/view_appointments.dart';
import 'package:focusmi/features/appointment/services/appointment_service.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatefulWidget {
  final int userId;

  AppointmentPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late List<dynamic> timeslotlist = [];
  int? selectedSessionId;
  late AppointmentService _appointmentService = AppointmentService();

  @override
  void initState() {
    super.initState();
    fetchTimeslotData();
  }

  Future<void> fetchTimeslotData() async {
    try {
      final data = await AppointmentService.getTimeSlotList(widget.userId);
      final currentTime = DateTime.now();
      var user = Provider.of<UserProvider>(context, listen: false).user;
      final existingAppointments =
          await AppointmentService.getPreviousAppointments(user.user_id);
      print(user.user_id);

      setState(() {
        timeslotlist = data.where((slot) {
          final sessionTime = DateTime.parse(slot['session_time']).toLocal();
          final sessionEndTime =
              DateTime.parse(slot['session_end_time']).toLocal();

          // Check if the time slot is after the current time and does not overlap with existing appointments
          return sessionTime.isAfter(currentTime) &&
              !hasAppointmentOverlap(
                  sessionTime, sessionEndTime, existingAppointments);
        }).toList();
      });

      if (timeslotlist.isEmpty) {
        // No available time slots, show a notification to the user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No available time slots. Please try again later.'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  bool hasAppointmentOverlap(DateTime startTime, DateTime endTime,
      List<dynamic> existingAppointments) {
    for (var appointment in existingAppointments) {
      final existingStartTime =
          DateTime.parse(appointment['session_time']).toLocal();
      final existingEndTime =
          DateTime.parse(appointment['session_end_time']).toLocal();

      // Check for overlap: new appointment starts before existing appointment ends
      // and new appointment ends after existing appointment starts
      if (startTime.isBefore(existingEndTime) &&
          endTime.isAfter(existingStartTime)) {
        return true; // There is an overlap
      }
    }
    return false; // No overlap detected
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.primaryColor,
        title: Text(
          'Appointment',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Time:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: timeslotlist.map<Widget>((slot) {
                  final sessionTime =
                      DateTime.parse(slot['session_time']).toLocal();
                  final sessionEndTime =
                      DateTime.parse(slot['session_end_time']).toLocal();
                  final isSelected = selectedSessionId == slot['session_id'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSessionId =
                            isSelected ? null : slot['session_id'];
                      });
                    },
                    child: Chip(
                      label: Text(
                        '${DateFormat('MMM d, yyyy - hh:mm a').format(sessionTime)} - ${DateFormat('hh:mm a').format(sessionEndTime)}',
                      ),
                      backgroundColor:
                          isSelected ? Colors.green : Colors.grey.shade300,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Process the form data
                    // ... other form processing logic ...
                    var user =
                        Provider.of<UserProvider>(context, listen: false).user;

                    AppointmentService.updateSession(
                        selectedSessionId!, user.user_id);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Appointment booked successfully!'),
                      backgroundColor: Colors.green,
                    ));

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const ViewAppointmentsWidget(),
                    //   ),
                    // );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please select a time slot.'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Book Appointment',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      GlobalVariables.primaryColor),
                  elevation: MaterialStateProperty.all<double>(3),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Appointment App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: AppointmentPage(
      userId: 0,
    ),
  ));
}
