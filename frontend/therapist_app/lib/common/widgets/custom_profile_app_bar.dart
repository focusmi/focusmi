import 'package:flutter/material.dart';
import 'package:therapist_app/constants/global_variables.dart';

class CustomProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomProfileAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: GlobalVariables.primaryText,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
