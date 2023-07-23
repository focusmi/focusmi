import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  const CustomTextField(
      {Key? key, required this.controller, required this.hinText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 3,left: 15),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow:[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 7
          )
        ]
      ),
      child: TextFormField(
        controller: controller,
        // obscureText: true,
        decoration: InputDecoration(
            hintText: hinText,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(0),
            hintStyle: const TextStyle(
              height: 1,
            ),
            // enabledBorder: const OutlineInputBorder(
            //     borderSide: BorderSide(color: Colors.black38))
                ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter your $hinText';
          }
          return null;
        },
      ),
    );
  }
}
