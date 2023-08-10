import 'package:flutter/material.dart';
import 'package:test/view_appointments.dart';
import 'constants/global_variables.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

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
    '09:00 A.M', '09:30 A.M', '10:00 A.M', '10:30 A.M',
    '11:00 A.M', '11:30 A.M', '12:00 A.M', '12:30 P.M'
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
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDatePicker(),
              verticalSpace(16),
              buildTimeChips(),
              verticalSpace(16),
              buildInputField('Full Name', _fullNameController, 'Please enter your full name'),
              verticalSpace(16),
              buildAgeDropdown(),
              verticalSpace(16),
              buildGenderChips(),
              verticalSpace(16),
              buildInputField('Problem Description', _problemDescriptionController, 'Please provide a problem description', maxLines: 3),
              verticalSpace(16),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Date', style: TextStyle(fontSize: 16)),
        ElevatedButton(
          onPressed: _selectDate,
          child: Text(_selectedDate != null
              ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
              : "Select Date"),
        ),
      ],
    );
  }

  Widget buildTimeChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Time:', style: TextStyle(fontSize: 16)),
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
      ],
    );
  }

  Widget buildInputField(String label, TextEditingController controller, String validationMessage, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validationMessage;
            }
            return null;
          },
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter $label',
          ),
        ),
      ],
    );
  }

  Widget buildAgeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Age:', style: TextStyle(fontSize: 16)),
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
      ],
    );
  }

  Widget buildGenderChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender:', style: TextStyle(fontSize: 16)),
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
      ],
    );
  }

  Widget buildSubmitButton() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FFButtonWidget(
              onPressed: _submitForm,
              text: 'Book Appointment',
              options: FFButtonOptions(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                color: const Color(0xFF83DE70),
                textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                ),
                elevation: 3,
                borderRadius: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper function to show date picker
  Future<void> _selectDate() async {
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
  }

  // Helper function to submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      print('Form submitted');
      print('Date: $_selectedDate');
      print('Time: $_selectedTime');
      print('Full Name: ${_fullNameController.text}');
      print('Age: $_selectedAge');
      print('Gender: $_selectedGender');
      print('Problem Description: ${_problemDescriptionController.text}');

      // Navigate to the view appointments screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (
