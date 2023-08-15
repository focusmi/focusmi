import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_theme.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_widgets.dart';
import 'package:focusmi/features/appointment/screens/view_appointments.dart';
import 'package:focusmi/features/appointment/services/appointment_service.dart';

import 'flutter_flow/flutter_flow_util.dart';

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

  @override
  void initState() {
    super.initState();
    fetchtimeslotData();
  }

  Future<void> fetchtimeslotData() async {
    try {
      final data = await AppointmentService.getTimeSlotList(widget.userId);
      setState(() {
        timeslotlist = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _problemDescriptionController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _problemDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Appointment',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Time:',
                style: TextStyle(fontSize: 16),
              ),
              Wrap(
                spacing: 8,
                children: timeslotlist.map(
                  (slot) {
                    final sessionTime = DateTime.parse(slot['session_time']);
                    final sessionEndTime =
                        DateTime.parse(slot['session_end_time']);
                    final isSelected = selectedSessionId == slot['session_id'];
                    return ChoiceChip(
                      label: Text(
                        '${DateFormat('MMM d, yyyy - hh:mm a').format(sessionTime)} - ${DateFormat('hh:mm a').format(sessionEndTime)}',
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedSessionId =
                              selected ? slot['session_id'] : null;
                        });
                      },
                    );
                  },
                ).toList(),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: FFButtonWidget(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process the form data
                            print('Selected Session ID: $selectedSessionId');
                            print('Full Name: ${_fullNameController.text}');
                            print(
                                'Problem Description: ${_problemDescriptionController.text}');
                            // ... other form processing logic ...
                            AppointmentService.updateSession(
                                selectedSessionId!, widget.userId);
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                            
                                  const ViewAppointmentsWidget(),
                            ),
                          );
                        },
                        text: 'Book Appointment',
                        options: FFButtonOptions(
                          height: 40,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 0, 24, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: const Color(0xFF83DE70),
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                  ),
                          elevation: 3,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 8,
                        ),
                      ),
                    ),
                  ),
                ],
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
