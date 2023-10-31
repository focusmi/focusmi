// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_theme.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_widgets.dart';
import 'package:focusmi/features/appointment/services/appointment_service.dart';

import '../../../constants/global_variables.dart';
import 'councillor_details.dart';

class CounselorsListWidgetWidget extends StatefulWidget {
  const CounselorsListWidgetWidget({Key? key}) : super(key: key);
  static const String routeName = '/select_councillor';

  @override
  _CounselorsListWidgetWidgetState createState() =>
      _CounselorsListWidgetWidgetState();
}

class _CounselorsListWidgetWidgetState
    extends State<CounselorsListWidgetWidget> {
  late List<dynamic> councillorData; // To store the fetched data

  @override
  void initState() {
    super.initState();
    fetchCouncillorData();
    councillorData = [];
  }

  Future<void> fetchCouncillorData() async {
    try {
      final data = await AppointmentService.getCouncillorList();
      setState(() {
        councillorData = data;
        print(councillorData);
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
            'Counsellors',
            style: TextStyle(color: Colors.white),
            // style: FlutterFlowTheme.of(context).bodyText1.override(
            //       fontFamily: 'Outfit',
            //       color: Colors.white,
            //       fontSize: 22,
            //     ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    for (var councillor in councillorData ?? [])
                      CouncillorCard(
                        imageUrl: '$uri/' + councillor['image'],
                        username: councillor['full_name'],
                        about: councillor['about'],
                        email: councillor['email'],
                        exp: councillor['years_of_experience'],
                        tot_clients: councillor['tot_clients'],
                        user_id: councillor['user_id'],
                      ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class CouncillorCard extends StatelessWidget {
  final String? imageUrl;
  final String? username;
  final String? about;
  final String? title;
  final String? email;
  final String? exp;
  final int? tot_clients;
  final int? user_id;

  CouncillorCard({
    Key? key,
    this.imageUrl,
    this.username,
    this.about,
    this.title,
    this.email,
    this.exp,
    this.tot_clients,
    this.user_id,
  }) : super(key: key);

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
                        image: NetworkImage(imageUrl ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username ?? '',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      Text(title ?? '', style: TextStyle(fontSize: 14))
                    ],
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
                        name: username ?? '',
                        email: email ?? '',
                        about: about ?? '',
                        title: title ?? '',
                        experience: exp ?? '',
                        image: imageUrl ?? '',
                        totcustomer: tot_clients ?? 0,
                        userId: user_id ?? 0,
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
