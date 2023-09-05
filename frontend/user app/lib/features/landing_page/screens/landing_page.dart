import 'package:flutter/material.dart';
import 'package:focusmi/layouts/user-layout.dart';

class LandinPage extends StatefulWidget {
  const LandinPage({super.key});

  @override
  State<LandinPage> createState() => _LandinPageState();
}

class _LandinPageState extends State<LandinPage> {
  @override
  Widget build(BuildContext context) {
    LayOut layOut = new LayOut();
    return layOut.mainLayout(
      Container(
        child: Column(
          children: [
            
          ]),
      )
    );
  }
}
