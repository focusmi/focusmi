import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:therapist_app/common/widgets/custom_profile_app_bar.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/constants/util.dart';

import '../service/set_time_schedule_service.dart';

class SetTimeScheduleScreen extends StatefulWidget {
  @override
  _SetTimeScheduleScreenState createState() => _SetTimeScheduleScreenState();
}

class _SetTimeScheduleScreenState extends State<SetTimeScheduleScreen> {
  List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  Map<String, List<TimeRange>> selectedTimePeriods = {};

  @override
  void initState() {
    super.initState();
  }

  Future<List<Schedule>> _fetchSchedules() async {
    try {
      List<Schedule> schedules =
          await SetTimeScheduleService.fetchSchedules(context);
      // Clear the existing selectedTimePeriods map
      selectedTimePeriods.clear();

      // Update the selectedTimePeriods map with the fetched schedules
      for (Schedule schedule in schedules) {
        String weekday = DateFormat('EEEE', 'en_US').format(schedule.start);
        if (!weekdays.contains(weekday)) continue;

        selectedTimePeriods[weekday] ??= [];
        selectedTimePeriods[weekday]!.add(TimeRange(
          context: context,
          start: schedule.start,
          end: schedule.end,
          selectedDate: DateFormat('yyyy-MM-dd').format(
              schedule.start), // Get the selected date in 'yyyy-MM-dd' format
        ));
      }

      return schedules;
    } catch (error) {
      // Handle error if needed
      print('Error fetching schedules: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomProfileAppBar(title: 'Set Appointment Time'),
      body: FutureBuilder<List<Schedule>>(
        future: _fetchSchedules(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the future is still waiting, show a loading indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If there was an error while fetching data, show an error message
            return Center(
              child: Text('Error fetching schedules: ${snapshot.error}'),
            );
          } else {
            // If the data was fetched successfully, build the rest of the screen
            // using the fetched data.
            return Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select weekdays:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: weekdays.map((weekday) {
                        final isSelected =
                            selectedTimePeriods.containsKey(weekday);
                        return FilterChip(
                          label: Text(
                            weekday,
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    isSelected ? Colors.white : Colors.black),
                          ),
                          selected: isSelected,
                          selectedColor: GlobalVariables.primaryText,
                          checkmarkColor: Colors.white,
                          side: BorderSide.none,
                          backgroundColor:GlobalVariables.greyBackgroundColor,
                          labelStyle: const TextStyle(color: Colors.white),
                          elevation: 2,
                          onSelected: (value) {
                            setState(() {
                              if (value) {
                                selectedTimePeriods[weekday] = [];
                              } else {
                                selectedTimePeriods.remove(weekday);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Select time periods:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: selectedTimePeriods.length,
                        itemBuilder: (context, index) {
                          final entry =
                              selectedTimePeriods.entries.toList()[index];
                          final weekday = entry.key;
                          final timePeriods = entry.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weekday,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: timePeriods.map((timeRange) {
                                  return Chip(
                                    label: Text(
                                      'Date\t${timeRange.selectedDate}\t\t\tTime\t${timeRange.formatTimeRange()}',
                                      //  style: GoogleFonts.abel(
                                      //   textStyle:  TextStyle(fontSize: 15, fontWeight:FontWeight.w600)
                                      //  ),
                                      style: TextStyle(fontSize: 15),
                                      //.getFormattedMonthDay() MM-DD
                                    ),
                                    elevation: 2,
                                    backgroundColor:
                                        GlobalVariables.greyBackgroundColor,
                                    deleteIconColor: Colors.red,
                                    side: BorderSide.none,
                                    onDeleted: () {
                                      print("delete");
                                      setState(() {
                                        timePeriods.remove(timeRange);
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 8),
                              IconButton.filled(onPressed: (){ _showDateTimePicker(context, weekday);}, icon:const Icon(Icons.add)),
                              const SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _editSchedule() {
    // Implement the edit schedule logic
  }

  Future<void> _showDateTimePicker(BuildContext context, String weekday) async {
    final initialTime = TimeOfDay.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate:
          DateTime.now().add(Duration(days: 14)), // Limit to the next 2 weeks
    );

    if (pickedDate != null) {
      final pickedStartTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (pickedStartTime != null) {
        final pickedEndTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );

        if (pickedEndTime != null) {
          final startDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedStartTime.hour,
            pickedStartTime.minute,
          );
          final endDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedEndTime.hour,
            pickedEndTime.minute,
          );

          final DateTime twoWeeksFromNow =
              DateTime.now().add(Duration(days: 14));
          if (startDateTime.isBefore(twoWeeksFromNow) &&
              endDateTime.isBefore(twoWeeksFromNow)) {
            final timeRange = TimeRange(
              context: context,
              start: startDateTime,
              end: endDateTime,
              selectedDate: DateFormat('yyyy-MM-dd').format(
                  pickedDate), // Get the selected date in 'yyyy-MM-dd' format
            );
            try {
              // Call the service method to create the schedule
              final response = await SetTimeScheduleService.createSchedule(
                  timeRange.toSchedule(), context);

              showSnackBar(context, 'Time period added successfully!');
              setState(() {
                selectedTimePeriods[weekday]?.add(timeRange);
              });
            } catch (error) {
              // If the createSchedule method throws an exception, it means the time period overlaps with existing schedules
              // Show an error message to the user
              showSnackBar(context, error.toString());
            }
          } else {
            // Handle the case where the selected time is not within the next two weeks
            // You can show an error message or take other appropriate actions here
          }
        }
      }
    }
  }
}
