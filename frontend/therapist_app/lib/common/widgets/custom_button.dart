import 'package:flutter/material.dart';
import 'package:therapist_app/constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButton({Key? key,
                     required this.text,
                     required this.onTap
                     }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text,
      style:  TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600
      ),),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))
        ),
        backgroundColor: GlobalVariables.primaryText,
      ),
    );
  }
}