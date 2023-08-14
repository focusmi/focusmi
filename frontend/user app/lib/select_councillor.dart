import 'package:flutter/material.dart';
import 'package:test/services/appointment_service.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

import '../../../constants/global_variables.dart';
import 'councillor_details.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late List<dynamic> councillorData; // To store the fetched data

  @override
  void initState() {
    super.initState();
    fetchCouncillorData();
  }

  Future<void> fetchCouncillorData() async {
    try {
      final data = await AppointmentService.getCouncillorList();
      setState(() {
        councillorData = data;
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
                for (var councillor in councillorData ?? [])
                  CouncillorCard(
                    imageUrl: 'https://picsum.photos/seed/87/600',
                    fullname: "Dr." + councillor['full_name'],
                    qulification: councillor['about'],
                    exp: councillor['years_of_experience'],
                    tot: councillor['tot_clients'],
                    userId: councillor['user_id'],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CouncillorCard extends StatelessWidget {
  final String imageUrl;
  final String fullname;
  final String qulification;
  final String exp;
  final int tot;
  final int userId;

  CouncillorCard({
    required this.imageUrl,
    required this.fullname,
    required this.qulification,
    required this.exp,
    required this.tot,
    required this.userId,
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
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    fullname,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsWidget(
                        name: fullname,
                        about: qulification,
                        experience: exp,
                        totcustomer: tot,
                        userId: userId,
                      ),
                    ),
                  );
                },
                text: 'Details',
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
