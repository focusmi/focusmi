import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/appointment/screens/add_appointment.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_theme.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_widgets.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/widgets/texts.dart';


import 'councillor_details_model.dart';
export 'councillor_details_model.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({Key? key}) : super(key: key);

  @override
  _DetailsWidgetState createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  late DetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  //void initState() {
  //super.initState();
  //_model = createModel(context, () => DetailsModel());
  //}

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();
    return layout.mainLayoutWithDrawer(
      context, 
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: SafeArea(
            top: true,
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://picsum.photos/seed/621/600',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                CustomText.titleText(
                  'Adam Thompson',
                ),
                CustomText.normalText(
                  'MBBS(Col)',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                    CustomText.normalText(
                      '1000+ Patients',
                      
                    ),
                    const SizedBox(width: 20),
                    CustomText.normalText(
                      '10 Yrs Experience',
                      
                    ),
                    const SizedBox(width: 20),
                   
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomText.normalText(
                    'Career',
                    
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomText.normalText(
                    'Mental Health Counselors, facilitating positive change through compassionate communication in a safe environment',
                    
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  
                  child:ElevatedButton(
                    child:CustomText.buttonWhiteText("Take Appointment Now"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.primaryColor
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        
                        MaterialPageRoute(
                          builder: (context) => const AppointmentPage(),
                        ),
                      );
                    },
                    
                    )
                ),
              ],
            ),
          ),
      ), 
      "Counselor Profile");
  }
}
