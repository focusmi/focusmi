import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/appointment/screens/add_appointment.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_theme.dart';
import 'package:focusmi/features/appointment/screens/flutter_flow/flutter_flow_widgets.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/widgets/containers.dart';
import 'package:focusmi/widgets/texts.dart';

import 'councillor_details.dart';
import 'select_councellor_model.dart';
export 'select_councellor_model.dart';

class CounselorsListWidget extends StatefulWidget {
  static const routeName = '/select_councillor';
  const CounselorsListWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CounselorsListWidgetState createState() => _CounselorsListWidgetState();
}

class _CounselorsListWidgetState extends State<CounselorsListWidget> {
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
    LayOut layout = LayOut();
    return layout.mainLayoutWithDrawer(
      context, 
      SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: CustomContainer.normalContainer(Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start ,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://picsum.photos/seed/87/600',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap:    () {
                             
                                    Navigator.push(
                      context,
                      
                      MaterialPageRoute(
                        builder: (context) => const AppointmentPage(),
                      ),
                    );
                                  },
                                child: Container(
                                 child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Adam Thompson\nMBBS(Col)',
                                        style:TextStyle(
                                          color:GlobalVariables.greyFontColor 
                                        ),
                                      ),
                                      Text(
                                        '12 years of experience as a life coach....',
                                        style: TextStyle(
                                            color: GlobalVariables.greyFontColor,
                                            fontSize: 12
                                        ),
                                        
                                      ),
                                    ],
                                  )
                                  ),
                              ),
                              GestureDetector(
                                onTap:(){Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                        builder: (context) =>
                                        const DetailsWidget()));
                                        
                                        },
                                        
                                child: Container(
                                  height: 30,
                                  child: Text(
                                    'Press here to see more',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: GlobalVariables.greyFontColor,
                                        fontSize: 12
                                    ),
                                    
                                  ),
                                ),
                              )
                            ],
                          ),
                    
                        ],
                      ),
                
                    ],
                  ),
                ),
                
                
              ],
            ), 115, 100),
          ),
        ),
      "Counselors"
    );
  }
}
