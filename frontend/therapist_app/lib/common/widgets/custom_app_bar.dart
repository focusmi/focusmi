import 'package:flutter/material.dart';
import 'package:therapist_app/constants/global_variables.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final ScrollController scrollController;
  final bool showFlexibleSpaceTitle;

  const CustomAppBar({
    required this.title,
    required this.scrollController,
    required this.showFlexibleSpaceTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      expandedHeight: 90,
      backgroundColor: showFlexibleSpaceTitle ? GlobalVariables.primaryText : Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: showFlexibleSpaceTitle ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
