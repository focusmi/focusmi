import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 3, left: 15),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0),
            // blurRadius: 7,
          ),
        ],
      ),
      child: Row( // Wrap the TextFormField and IconButton in a Row
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              obscureText: _obscureText, // Use the local _obscureText variable
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(0),
                hintStyle: const TextStyle(
                  height: 1,
                ),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Enter your ${widget.hintText}';
                }
                return null;
              },
            ),
          ),
          if (widget.obscureText) // Only show the icon if it's a password field
            IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
        ],
      ),
    );
  }
}
