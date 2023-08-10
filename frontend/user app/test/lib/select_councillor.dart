import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import 'councillor_details.dart';
import 'select_councellor_model.dart';
export 'select_councellor_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  //void initState() {
  //super.initState();
  //_model = createModel(context, () => HomePageModel());
  //}

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
        backgroundColor: GlobalVariables.backgroundColor,
        appBar: AppBar(
          backgroundColor: const Color(0xFF83DE70),
          automaticallyImplyLeading: false,
          title: Text(
            'Councillors',
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://picsum.photos/seed/87/600',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'Dr. Adam Thompson\nMBBS(Col)',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.date_range,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      Text(
                        'Saturday, 12 JUNE',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                      Align(
                        alignment: const AlignmentDirectional(1, 0),
                        child: Icon(
                          Icons.access_time,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24,
                        ),
                      ),
                      Text(
                        '11.00-12.00 AM',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10, 10, 10, 10),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DetailsWidget()));
                          },
                          text: 'Details',
                          options: FFButtonOptions(
                            height: 40,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 0, 24, 0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
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
      ),
    );
  }
}
