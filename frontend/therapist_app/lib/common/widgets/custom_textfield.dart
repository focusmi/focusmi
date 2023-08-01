import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator; // Add the validator parameter
  final bool trimEnabled; // Add the trimEnabled parameter

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator, // Provide a default value of null for the validator
    this.trimEnabled = true, // Provide a default value of true for trimEnabled
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
      child: Row(
        // Wrap the TextFormField and IconButton in a Row
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              obscureText: _obscureText, // Use the local _obscureText variable
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                hintText: widget.hintText,
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight
                      .bold, // Set the font weight of the error message text
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide
                      .none, // Set the border to none when there is an error
                  borderRadius: BorderRadius.circular(12),
                ),
                // contentPadding: const EdgeInsets.all(0),
              ),
              validator: (value) {
                // Trim the value before validating if trimEnabled is true and the value is not null
                if (widget.trimEnabled && value != null) {
                  value = value.trim();
                }
                return widget.validator
                    ?.call(value); // Use the provided validator
              },
            ),
          ),
          if (widget.obscureText) // Only show the icon if it's a password field
            Center(
              child: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
