import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_theme.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_widgets.dart';
import 'package:focusmi/features/appointment/screens/view_appointments.dart';


class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _selectedTime;
  String? _selectedGender;
  String? _selectedAge;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _problemDescriptionController = TextEditingController();

  List<String> _ages = List.generate(80, (index) => (index + 1).toString());

  List<String> _genders = ['Male', 'Female'];

  List<String> _times = [
    '09:00 A.M',
    '09:30 A.M',
    '10:00 A.M',
    '10:30 A.M',
    '11:00 A.M',
    '11:30 A.M',
    '12:00 A.M',
    '12:30 P.M'
  ];

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
        actions: [],
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
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                child: Text(_selectedDate != null
                    ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                    : "Select Date"),
              ),
              SizedBox(height: 16),
              Text(
                'Select Time:',
                style: TextStyle(fontSize: 16),
              ),
              Wrap(
                spacing: 8,
                children: _times
                    .map(
                      (time) => ChoiceChip(
                        label: Text(time),
                        selected: _selectedTime == time,
                        onSelected: (selected) {
                          setState(() {
                            _selectedTime = selected ? time : null;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 16),
              Text(
                'Full Name:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                controller: _fullNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Age:',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButtonFormField<String>(
                value: _selectedAge,
                onChanged: (newValue) {
                  setState(() {
                    _selectedAge = newValue;
                  });
                },
                items: _ages.map<DropdownMenuItem<String>>(
                  (age) {
                    return DropdownMenuItem<String>(
                      value: age,
                      child: Text(age),
                    );
                  },
                ).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select your age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Gender:',
                style: TextStyle(fontSize: 16),
              ),
              Wrap(
                spacing: 8,
                children: _genders
                    .map(
                      (gender) => ChoiceChip(
                        label: Text(gender),
                        selected: _selectedGender == gender,
                        onSelected: (selected) {
                          setState(() {
                            _selectedGender = selected ? gender : null;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 16),
              Text(
                'Problem Description:',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                controller: _problemDescriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a problem description';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                          if (_formKey.currentState!.validate()) {
                            // Process the form data
                            print('Form submitted');
                            print('Date: $_selectedDate');
                            print('Time: $_selectedTime');
                            print('Full Name: ${_fullNameController.text}');
                            print('Age: $_selectedAge');
                            print('Gender: $_selectedGender');
                            print(
                                'Problem Description: ${_problemDescriptionController.text}');
                          }
                        
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ViewAppointmentsWidget()));
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
