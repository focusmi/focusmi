import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:therapist_app/common/widgets/schedule_card.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/schedule/service/scheduleservice.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../provider/user_provider.dart';

enum ScheduleFilter {All, Today, Past, Next } // Added 'Next'

class UpcomingScheduleScreen extends StatefulWidget {
  @override
  _UpcomingScheduleScreenState createState() => _UpcomingScheduleScreenState();
}

class _UpcomingScheduleScreenState extends State<UpcomingScheduleScreen> {
  List<dynamic> scheduleData = [];
  bool isLoading = true;
  ScheduleFilter selectedFilter = ScheduleFilter.All;

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
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching schedule data: $e');
      setState(() {
        isLoading = false;
      });
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilterChip(
                label: Text(
                  "\t\tAll\t\t",
                  style: TextStyle(
                      fontSize: 14,
                      color: selectedFilter == ScheduleFilter.All
                          ? Colors.white
                          : Colors.black),
                ),
                selected: selectedFilter == ScheduleFilter.All,
                showCheckmark: false,
                selectedColor: GlobalVariables.primaryText,
                checkmarkColor: Colors.white,
                side: BorderSide.none,
                backgroundColor: GlobalVariables.greyBackgroundColor,
                labelStyle: const TextStyle(color: Colors.white),
                elevation: 2,
                onSelected: (_) {
                  setState(() {
                    selectedFilter = ScheduleFilter.All;
                  });
                },
              ),
              SizedBox(width: 15),
              FilterChip(
                label: Text(
                  "Today",
                  style: TextStyle(
                      fontSize: 14,
                      color: selectedFilter == ScheduleFilter.Today
                          ? Colors.white
                          : Colors.black),
                ),
                selected: selectedFilter == ScheduleFilter.Today,
                selectedColor: GlobalVariables.primaryText,
                checkmarkColor: Colors.white,
                side: BorderSide.none,
                backgroundColor: GlobalVariables.greyBackgroundColor,
                labelStyle: const TextStyle(color: Colors.white),
                elevation: 2,
                showCheckmark: false,
                onSelected: (_) {
                  setState(() {
                    selectedFilter = ScheduleFilter.Today;
                  });
                },
              ),
              SizedBox(width: 15),
              FilterChip(
                label: Text(
                  "Next",
                  style: TextStyle(
                      fontSize: 14,
                      color: selectedFilter == ScheduleFilter.Next
                          ? Colors.white
                          : Colors.black),
                ), // Added 'Next'
                selected: selectedFilter == ScheduleFilter.Next,
                selectedColor: GlobalVariables.primaryText,
                checkmarkColor: Colors.white,
                side: BorderSide.none,
                backgroundColor: GlobalVariables.greyBackgroundColor,
                labelStyle: const TextStyle(color: Colors.white),
                elevation: 2,
                showCheckmark: false,
                onSelected: (_) {
                  setState(() {
                    selectedFilter = ScheduleFilter.Next;
                  });
                },
              ),
              SizedBox(width: 15),
              FilterChip(
                label: Text(
                  "Past",
                  style: TextStyle(
                      fontSize: 14,
                      color: selectedFilter == ScheduleFilter.Past
                          ? Colors.white
                          : Colors.black),
                ),
                selected: selectedFilter == ScheduleFilter.Past,
                selectedColor: GlobalVariables.primaryText,
                checkmarkColor: Colors.white,
                side: BorderSide.none,
                backgroundColor: GlobalVariables.greyBackgroundColor,
                labelStyle: const TextStyle(color: Colors.white),
                elevation: 2,
                showCheckmark: false,
                onSelected: (_) {
                  setState(() {
                    selectedFilter = ScheduleFilter.Past;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            )
          else if (scheduleData.isEmpty)
            Center(
              child: Container(
                height: 200,
                margin: const EdgeInsets.only(top: 100),
                child:
                    Lottie.asset('assets/images/Comp.json', fit: BoxFit.cover),
              ),
            )
          else
            scheduleData
                  .where((schedule) {
                    if (selectedFilter == ScheduleFilter.Today) {
                      final now = DateTime.now();
                      final appointmentDateTime =
                          DateTime.parse(schedule['appointment_datetime']);
                      return appointmentDateTime.day == now.day &&
                          appointmentDateTime.month == now.month &&
                          appointmentDateTime.year == now.year;
                    } else if (selectedFilter == ScheduleFilter.Past) {
                      return DateTime.parse(schedule['appointment_datetime'])
                          .isBefore(DateTime.now());
                    } else if (selectedFilter == ScheduleFilter.Next) {
                      // Added 'Next'
                      return DateTime.parse(schedule['appointment_datetime'])
                          .isAfter(DateTime.now());
                    }
                    return true; // Show all by default
                  })
                  .isEmpty // Check if the filtered list is empty
              ? Center(
              child: Container(
                height: 200,
                margin: const EdgeInsets.only(top: 100),
                child:
                    Lottie.asset('assets/images/Comp.json', fit: BoxFit.cover),
              ),
            )
              : Column(
                  children: scheduleData
                      .where((schedule) {
                        if (selectedFilter == ScheduleFilter.Today) {
                          final now = DateTime.now();
                          final appointmentDateTime =
                              DateTime.parse(schedule['appointment_datetime']);
                          return appointmentDateTime.day == now.day &&
                              appointmentDateTime.month == now.month &&
                              appointmentDateTime.year == now.year;
                        } else if (selectedFilter == ScheduleFilter.Past) {
                          return DateTime.parse(schedule['appointment_datetime'])
                              .isBefore(DateTime.now());
                        } else if (selectedFilter == ScheduleFilter.Next) {
                          // Added 'Next'
                          return DateTime.parse(schedule['appointment_datetime'])
                              .isAfter(DateTime.now());
                        }
                        return true; // Show all by default
                      })
                      .map((schedule) {
                        return ScheduleCard(
                          patientName: schedule['patient_name'],
                          appointmentDate: formatAppointmentDateTime(
                              schedule['appointment_datetime']),
                          // appointmentTime: schedule['appointment_time'],
                          // status: schedule['status'],
                        );
                      })
                      .toList(),
                ),
        ],
      ),
    );
  }
}
