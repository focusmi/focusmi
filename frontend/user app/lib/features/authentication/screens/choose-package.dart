import 'package:flutter/material.dart';
import 'package:focusmi/features/task_group.dart/screens/group_list.dart';
import 'package:focusmi/layouts/user-layout.dart';

class ChoosePackage extends StatefulWidget {
  const ChoosePackage({super.key});
  static const routeName = "/choose-package";
  @override
  State<ChoosePackage> createState() => _ChoosePackageState();
}

class _ChoosePackageState extends State<ChoosePackage> {
  void changePackageApi(package) {}
  @override
  Widget build(BuildContext context) { 
    LayOut layout = LayOut();
    return layout.mainLayout(
    SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Text("Free Package"),
                ElevatedButton(
                    onPressed: () {
                      changePackageApi(1);
                    },
                    child: Text("Select Package"))
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text("Freedom Package"),
                ElevatedButton(
                    onPressed: () {
                      changePackageApi(2);
                    },
                    child: Text("Select Package"))
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text("Extra Freedom Package"),
                ElevatedButton(
                    onPressed: () {
                      changePackageApi(3);
                    },
                    child: Text("Select Package"))
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, GroupList.routeName);
              },
              child: Text("Skip"))
        ],
      )),
    ));
  }
}
