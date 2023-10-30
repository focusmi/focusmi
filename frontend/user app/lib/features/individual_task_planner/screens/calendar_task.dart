import 'package:flutter/material.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});
  static const String routeName = '/calendar_task';

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  LayOut layout = LayOut();
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();

  Widget build(BuildContext context) {
    return layout.mainLayoutWithDrawer(
        context,
        Container(
          child: TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                print("dfd"); // update `_focusedDay` here as well
              });
            },
          ),
        ),
        "Calendar Tasks");
  }
}
