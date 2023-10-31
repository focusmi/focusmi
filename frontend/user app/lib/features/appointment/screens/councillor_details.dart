import 'package:flutter/material.dart';
import 'package:focusmi/features/appointment/screens/add_appointment.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_theme.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_widgets.dart';

import 'councillor_details_model.dart';
export 'councillor_details_model.dart';

class DetailsWidget extends StatefulWidget {
  final String name;
  final String email;
  final String image;
  final String about;
  final String title;
  final String experience;
  final int totcustomer;
  final int userId;

  DetailsWidget({
    Key? key,
    required this.name,
    required this.image,
    required this.email,
    required this.about,
    required this.title,
    required this.experience,
    required this.totcustomer,
    required this.userId,
  }) : super(key: key);

  @override
  _DetailsWidgetState createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  late DetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: const Color(0xFF83DE70),
          automaticallyImplyLeading: false,
          title: Text(
            'Counsellor Profile',
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 120,
                        height: 120,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '${widget.name}',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 20,
                        ),
                  ),
                  Text(
                    '${widget.title}',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Readex Pro',
                          color: const Color(0xFF505056),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.people,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24,
                        ),
                        Icon(
                          Icons.explicit,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.totcustomer}+ Patients',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                      const SizedBox(width: 30),
                      Text(
                        '${widget.experience} Yrs Experience',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'About ',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 20,
                          ),
                    ),
                  ),
                  Text(
                    '${widget.about}',
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Contact',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 20,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.email,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AppointmentPage(userId: widget.userId),
                          ),
                        );
                      },
                      text: 'Book Appointment',
                      options: FFButtonOptions(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        iconPadding: const EdgeInsets.symmetric(horizontal: 0),
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
                ],
              ),
            )),
      ),
    );
  }
}
