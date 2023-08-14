import 'dart:math';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/auth/screens/email_verification_screen.dart';
import 'package:therapist_app/features/auth/screens/phone_verification_screen.dart';
import 'package:therapist_app/features/auth/services/email_sender.dart';
import '../../../common/widgets/custom_profile_app_bar.dart';
import '../../../provider/user_provider.dart';
import '../../../validation/form_validators.dart';
import '../../auth/services/auth_service.dart';

class ProfileDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: Color(0xffebecee),
      appBar: const CustomProfileAppBar(title: 'Profile Details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileField(
                label: 'Joined Date',
                value: '30 Jan, 2023',
                arrow: false,
                onTap: () {
                  // navigateToEditPage(context, 'Full Name', user.name);
                },
              ),
              const SizedBox(height: 2.0),
              ProfileField(
                label: 'Full Name',
                value: user.name,
                arrow: true,
                onTap: () {
                  navigateToEditPage(context, 'Full Name', user.name);
                },
              ),
              const SizedBox(height: 2.0),
              ProfileField(
                label: 'Email',
                value: user.email,
                arrow: true,
                onTap: () {
                  navigateToEditPage(context, 'Email', user.email);
                },
              ),
              const SizedBox(height: 2.0),
              ProfileField(
                label: 'Mobile Number',
                value: user.mobile,
                arrow: true,
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(type: PageTransitionType.leftToRight, child: PhoneVerificationScreen())
                  );
                },
              ),
              const SizedBox(height: 2.0),
              ProfileField(
                label: 'Experience',
                value: '${user.experience}',
                arrow: true,
                onTap: () {
                  navigateToEditPage(
                      context, 'Experience', user.experience.toString());
                },
              ),
              const SizedBox(height: 2.0),
              ProfileField(
                label: 'Address',
                value: 'address',
                arrow: true,
                onTap: () {
                  navigateToEditPage(
                      context, 'Address', 'No 456/1, Matara, Sri Lanka');
                },
              ),
              const SizedBox(height: 2.0),
              ProfileField(
                label: 'Password',
                value: '********',
                arrow: true,
                onTap: () {
                  navigateToChangePasswordPage(context);
                },
              ),
              const SizedBox(height: 2.0),
              ProfileField(
                label: 'Total Clients',
                value: '${user.clients}',
                arrow: false,
                onTap: () {},
              ),
              const SizedBox(height: 2.0),
              ProfileField(
                label: 'About',
                value: user.about,
                arrow: true,
                onTap: () {
                  navigateToEditPage(context, 'About', user.about);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToEditPage(
      BuildContext context, String field, String initialValue) {
    Navigator.push(
      context,
      PageTransition(type: PageTransitionType.leftToRight, child: ProfileEditPage(field: field, initialValue: initialValue)),
    );
  }

  void navigateToChangePasswordPage(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(type: PageTransitionType.leftToRight, child: ChangePasswordPage()),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool arrow;

  const ProfileField(
      {required this.label,
      required this.value,
      required this.onTap,
      required this.arrow});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    String fieldValue;
    if (label == 'Full Name') {
      fieldValue = user.name;
    } else if (label == 'Email') {
      fieldValue = user.email;
    } else if (label == 'Address') {
      fieldValue = 'No 456/1, Matara, Sri Lanka';
    } else if (label == 'Experience') {
      fieldValue = '${user.experience} years';
    } else if (label == 'Mobile Number') {
      fieldValue = '${user.mobile}';
    } else if (label == 'Joined Date') {
      fieldValue = '30 Jan, 2023';
    } else if (label == 'Password') {
      fieldValue = '●●●●●●●●●'; // Display masked password
    } else if (label == 'Total Clients') {
      fieldValue = '${user.clients}';
    } else if (label == 'About') {
      fieldValue = '${user.about}';
    } else {
      fieldValue = ''; // Default value if field label doesn't match
    }

    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.grey[50], // Gray background color
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      fieldValue,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: GlobalVariables
                            .greyTextColor, // Black value text color
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              if (arrow)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey[400], // Gray arrow icon color
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileEditPage extends StatefulWidget {
  final String field;
  final String initialValue;

  const ProfileEditPage({required this.field, required this.initialValue});

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final AuthService _authService = AuthService();
  late TextEditingController _textEditingController;
  String?
      _errorText; // Store the error message if data is invalid, otherwise null.

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void sendEmail(verificationCode, updatedValue) async {
    await EmailSender.sendEmail(
      recipientEmail: updatedValue.trim(),
      subject: 'Email Verification Code',
      body: 'Your verification code is: $verificationCode',
    );
  }

  // Validation functions for email and full name.
  String? _validateEmail(String value) {
    return FormValidators.validateEmail(value);
  }

  String? _validateFullName(String value) {
    return FormValidators.validateFullName(value);
  }

  String? _validatePassword(String value) {
    return FormValidators.validatePassword(value);
  }

  void _updateUser() {
    final updatedValue = _textEditingController.text;
    String? error;

    // Validate the input based on the field being edited.
    if (widget.field == 'Email') {
      error = _validateEmail(updatedValue);
    } else if (widget.field == 'Full Name') {
      error = _validateFullName(updatedValue);
    }

    // Check if the new value is the same as the initial value.
    if (updatedValue == widget.initialValue) {
      error = 'The new value is the same as the current value.';
    }

    if (error == null) {
      // Data is valid, proceed with the update.
      if (widget.field == 'Email') {
        final random = Random();
        final verificationCode = random.nextInt(9000) + 1000;
        sendEmail(verificationCode, updatedValue);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmailUpdateVerificationScreen(
              verificationCode: verificationCode,
              context: context,
              field: widget.field,
              value: updatedValue,
            ),
          ),
        );
      }

      if (widget.field != 'Email') {
        _authService.updateUser(
          context: context,
          field: widget.field,
          value: updatedValue,
        );
        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: ProfileDetailsPage()));
      }
    } else {
      setState(() {
        _errorText = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double buttonWidth = screenWidth * 0.8;
    return Scaffold(
      appBar: CustomProfileAppBar(title: "Edit ${widget.field}"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('${widget.field}',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 16)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _textEditingController,
                      onChanged: (value) {
                        // Clear the error message when the user starts typing.
                        setState(() {
                          _errorText = null;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintText: 'Edit ${widget.field}',
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
                        hintStyle: TextStyle(
                            color: Colors.grey.shade500, fontSize: 16),
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
                        errorText: _errorText,
                        // contentPadding: const EdgeInsets.all(0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: ElevatedButton(
                onPressed: _updateUser,
                child: Text(
                  'Update ${widget.field}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(buttonWidth, 50),
                  elevation: 2,
                  backgroundColor: GlobalVariables.primaryText,
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  String? _errorText;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _changePassword(String id) {
    final String userid = id;
    final String oldPassword = _oldPasswordController.text;
    final String newPassword = _newPasswordController.text;

    // Validate the passwords.
    String? error =
        FormValidators.validateChangePassword(oldPassword, newPassword);

    if (error != null) {
      // Set the error text for the respective fields.
      setState(() {
        _errorText = error;
      });
      return;
    }

    // If both passwords are valid, proceed with changing the password.
    AuthService.changePassword(
      context: context,
      oldPassword: oldPassword,
      newPassword: newPassword,
      userId: userid,
    ).then((success) {
      if (success) {
        // Password changed successfully
        // You can show a success message or perform any other actions
        print('Password changed successfully');
        Navigator.pop(context); // Go back to the profile details page
      } else {
        // Error changing password
        // You can show an error message or perform any other actions
        print('Failed to change password');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: const CustomProfileAppBar(title: "Change Password"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Old Password',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
              const SizedBox(height: 10),
              TextField(
                controller: _oldPasswordController,
                obscureText: _obscureText1,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Old Password',
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
                  hintStyle:
                      TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText1 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey.shade500,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText1 =
                            !_obscureText1; // Toggle the value of _obscureText
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text('New Password',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
              const SizedBox(height: 10),
              TextField(
                controller: _newPasswordController,
                obscureText: _obscureText2,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'New Password',
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
                  hintStyle:
                      TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorText: _errorText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText2 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey.shade500,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText2 =
                            !_obscureText2; // Toggle the value of _obscureText
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      _changePassword((user.id).toString());
                    },
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                      elevation: 2,
                      backgroundColor: GlobalVariables.primaryText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
