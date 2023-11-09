import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:therapist_app/features/schedule/service/set_time_schedule_service.dart';

class BarChartSample extends StatefulWidget {
  @override
  State<BarChartSample> createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  double? maxYValue;
  Future<void> _fetchAndSetMaxYValue() async {
    try {
      Map<String, Map<String, int>> timeSlots = await _fetchSchedules();

      // Get the maximum count of time slots from both weeks
      double maxTimeSlots = timeSlots.values
          .map((week) => week.values.reduce((a, b) => a > b ? a : b))
          .reduce((a, b) => a > b ? a : b)
          .toDouble();

      setState(() {
        maxYValue = maxTimeSlots + 1; // Adjust the value as needed
      });
    } catch (error) {
      print('Error fetching schedules: $error');
      // Handle error if needed
    }
  }

  Future<Map<String, Map<String, int>>> _fetchSchedules() async {
    try {
      DateTime now = DateTime.now();

      // Calculate the start and end of this week
      DateTime startOfWeek =
          DateTime(now.year, now.month, now.day - now.weekday);
      DateTime endOfWeek = startOfWeek.add(Duration(days: 7));

      // Calculate the start and end of the second week
      DateTime startOfSecondWeek =
          DateTime(now.year, now.month, now.day - now.weekday + 7);
      DateTime endOfSecondWeek = startOfSecondWeek.add(Duration(days: 7));

      List<Schedule> schedules =
          await SetTimeScheduleService.fetchSchedules(context);

      // Initialize maps to store the count of time slots for each day
      Map<String, int> timeSlotsThisWeek = {
        'Sun': 0,
        'Mon': 0,
        'Tue': 0,
        'Wed': 0,
        'Thu': 0,
        'Fri': 0,
        'Sat': 0,
      };

      Map<String, int> timeSlotsSecondWeek = {
        'Sun': 0,
        'Mon': 0,
        'Tue': 0,
        'Wed': 0,
        'Thu': 0,
        'Fri': 0,
        'Sat': 0,
      };

      for (Schedule schedule in schedules) {
        if (schedule.start.isAfter(startOfWeek) &&
            schedule.start.isBefore(endOfWeek)) {
          String? weekday = DateFormat('E', 'en_US').format(schedule.start);
          if (weekday != null) {
            // Increment the count for the respective day in this week
            timeSlotsThisWeek[weekday] = (timeSlotsThisWeek[weekday] ?? 0) + 1;
          }
        } else if (schedule.start.isAfter(startOfSecondWeek) &&
            schedule.start.isBefore(endOfSecondWeek)) {
          String? weekday = DateFormat('E', 'en_US').format(schedule.start);
          if (weekday != null) {
            // Increment the count for the respective day in the second week
            timeSlotsSecondWeek[weekday] =
                (timeSlotsSecondWeek[weekday] ?? 0) + 1;
          }
        }
      }
      return {
        'thisWeek': timeSlotsThisWeek,
        'secondWeek': timeSlotsSecondWeek,
      };
    } catch (error) {
      // Handle error if needed
      print('Error fetching schedules: $error');
      return {};
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchSchedules();
    _fetchAndSetMaxYValue();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BarChartGroupData>>(
      future: getBarGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available.'));
        } else {
          List<BarChartGroupData> barGroups = snapshot.data!;

          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 239, 251, 241)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxYValue, // Adjust the maximum y-axis value as needed
                      gridData: FlGridData(
                        show: false,
                      ),
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.white,
                          tooltipRoundedRadius: 10,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: SideTitles(showTitles: false),
                        rightTitles: SideTitles(showTitles: false),
                        topTitles: SideTitles(showTitles: false),
                        bottomTitles: SideTitles(
                          showTitles: true,
                          margin: 10,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return 'Sun';
                              case 1:
                                return 'Mon';
                              case 2:
                                return 'Tue';
                              case 3:
                                return 'Wed';
                              case 4:
                                return 'Thu';
                              case 5:
                                return 'Fri';
                              case 6:
                                return 'Sat';
                              default:
                                return '';
                            }
                          },
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      axisTitleData: FlAxisTitleData(show: false),
                      barGroups: barGroups,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<BarChartGroupData>> getBarGroups() async {
    // Call the function to fetch schedules and get the count of time slots per day for both weeks
    Map<String, Map<String, int>> timeSlots = await _fetchSchedules();

    // Define the order of days in a week
    List<String> daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return List.generate(7, (index) {
      String day = daysOfWeek[index];
      int timeSlotsCountThisWeek = timeSlots['thisWeek']?[day] ?? 0;
      int timeSlotsCountSecondWeek = timeSlots['secondWeek']?[day] ?? 0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            y: timeSlotsCountThisWeek.toDouble(),
            colors: [Color.fromARGB(255, 95, 204, 78)],
          ),
          BarChartRodData(
            y: timeSlotsCountSecondWeek.toDouble(),
            colors: [Color.fromARGB(255, 21, 108, 30)],
          ),
        ],
      );
    });
  }
}

