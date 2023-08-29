import 'package:flutter/material.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';


class MainScreen extends StatefulWidget {
  static const String routeName = '/main_page';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 
  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();
    double screenWidth = MediaQuery.of(context).size.width;
    final user = Provider.of<UserProvider>(context).user;
    return layout.mainLayout(
        Column(
                children: [
                  
                  Container(
                        margin: EdgeInsets.all(screenWidth*0.05),
                        width:screenWidth ,
                        decoration:     BoxDecoration(
                          borderRadius: BorderRadius.circular(5), 
                          border: Border.all(),
                          color: Colors.white
                        ),
                        child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(
                              
                              child:Text((user.user_id).toString())
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                    "Recent Task Plans",
                                    style: TextStyle(
                                        fontSize: 13,
                                    )
                              ),
                            ),
                          ],
                        ),
                    )
                ]
        )
    );
  }
}