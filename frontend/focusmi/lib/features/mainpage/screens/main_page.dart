import 'package:flutter/material.dart';
import 'package:focusmi/layouts/user-layout.dart';


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
    return layout.mainLayout(
        Column(
                children: [
    
                  Container(
                        width: 339,
                        height: 169,
                        decoration:     BoxDecoration(
                        borderRadius: BorderRadius.circular(5), 
                        color: Colors.white),
                        child:const Column(
                        children: [
                            Text(
                                  "Recent Task Plans",
                                  style: TextStyle(
                                      fontSize: 13,
                                  )
                            ),
                          ],
                        ),
                    )
                ]
        )
    );
  }
}