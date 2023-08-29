import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_theme.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_widgets.dart';
import 'package:focusmi/features/appointment/services/appointment_service.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ViewAppointmentsWidget extends StatefulWidget {
  const ViewAppointmentsWidget({Key? key}) : super(key: key);

  @override
  _ViewAppointmentsWidgetState createState() => _ViewAppointmentsWidgetState();
}

class _ViewAppointmentsWidgetState extends State<ViewAppointmentsWidget> {
  late List<dynamic> appointmentData = []; // To store the fetched data

  @override
  void initState() {
    super.initState();
    fetchAppointmentData();
  }

  Future<void> fetchAppointmentData() async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;
      print(user.user_id);
      final data = await AppointmentService.getAppointments(user.user_id);
      setState(() {
        appointmentData = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: GlobalVariables.backgroundColor,
        appBar: AppBar(
          backgroundColor: const Color(0xFF83DE70),
          automaticallyImplyLeading: false,
          title: Text(
            'Your Appointments',
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (var appointment in appointmentData ?? [])
                  AppointmentCard(
                    appointmentNo: appointment['appointment_id'],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final int appointmentNo;
  AppointmentCard({
    required this.appointmentNo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Appointment No :" + appointmentNo.toString(),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: FFButtonWidget(
                onPressed: () {
                  print('Button pressed ...');
                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(
                  //   //   builder: (context) => DetailsWidget(
                  //   //     name: fullname,
                  //   //     about: qulification,
                  //   //     experience: exp,
                  //   //     totcustomer: tot,
                  //   //     userId: userId,
                  //   //   ),
                  //   // ),
                  // );
                },
                text: 'More Info',
                options: FFButtonOptions(
                  height: 40,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  color: const Color(0xFF83DE70),
                  textStyle: FlutterFlowTheme.of(context).bodyText1.override(
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
          ],
        ),
      ),
    );
  }
}
