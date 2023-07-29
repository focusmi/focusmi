import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:therapist_app/constants/global_variables.dart';


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
    'Sunday'
  ];

  Map<String, List<TimeRange>> selectedTimePeriods = {};

  @override
  void initState() {
    super.initState();
    // Fetch schedules when the screen is initialized
    _fetchSchedules();
  }

  Future<void> _fetchSchedules() async {
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
        ));
      }

      // Force a rebuild of the widget tree
      setState(() {});
    } catch (error) {
      // Handle error if needed
      print('Error fetching schedules: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
         backgroundColor:GlobalVariables.primaryText,
        title: const Text('Set Appointment Time',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          ),
        
      ),
      body: Padding(
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
                final isSelected = selectedTimePeriods.containsKey(weekday);
                return FilterChip(
                  label: Text(weekday),
                  selected: isSelected,
                  selectedColor: GlobalVariables.primaryText,
                  checkmarkColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle: const TextStyle(
                   color: Colors.white
                  ),
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
                  final entry = selectedTimePeriods.entries.toList()[index];
                  final weekday = entry.key;
                  final timePeriods = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weekday,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: timePeriods.map((timeRange) {
                          return Chip(
                            label: Text(
                              timeRange.formatTimeRange(),
                            ),
                            deleteIconColor:Colors.red,
                            onDeleted: () {
                              setState(() {
                                timePeriods.remove(timeRange);
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton.small(
                        onPressed: () {
                          _showDateTimePicker(context, weekday);
                        },
                        child: const Icon(Icons.add),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     _showDateTimePicker(context, weekday);
                      //   },
                      //   child: Text(
                      //     'Add Time Period',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 14,
                      //     ),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     elevation: 2,
                      //     backgroundColor: GlobalVariables.primaryText,
                      //   ),
                      // ),
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

  void _editSchedule() {
    // Implement the edit schedule logic
  }

  Future<void> _showDateTimePicker(BuildContext context, String weekday) async {
    final initialTime = TimeOfDay.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)), // Adjust as needed
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
          final timeRange = TimeRange(
              context: context, start: startDateTime, end: endDateTime);
          setState(() {
            selectedTimePeriods[weekday]?.add(timeRange);
          });

          // Call the service method to create the schedule
          SetTimeScheduleService.createSchedule(
              timeRange.toSchedule(), context);
        }
      }
    }
  }
}
