import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist_app/constants/global_variables.dart';
import '../../../common/widgets/custom_profile_app_bar.dart';
import '../../../constants/util.dart';
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
                value: '077 379 4567',
                arrow: true,
                onTap: () {
                  // navigateToEditPage(context, 'Email', user.email);
                },
              ),
              const SizedBox(height: 2.0),
              ProfileField(
                label: 'Years of experience',
                value: '10',
                arrow: true,
                onTap: () {
                  // navigateToEditPage(context, 'Address', '');
                },
              ),
              const SizedBox(height: 2.0),
              ProfileField(
                label: 'Address',
                value: 'address',
                arrow: true,
                onTap: () {
                  // navigateToEditPage(context, 'Address', '');
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
                value: '',
                arrow: false,
                onTap: () {},
              ),
              const SizedBox(height: 2.0),
              ProfileField(
                label: 'About',
                value: '',
                arrow: true,
                onTap: () {},
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
      MaterialPageRoute(
        builder: (context) =>
            ProfileEditPage(field: field, initialValue: initialValue),
      ),
    );
  }

  void navigateToChangePasswordPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangePasswordPage(),
      ),
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
    } else if (label == 'Years of experience') {
      fieldValue = '10';
    } else if (label == 'Mobile Number') {
      fieldValue = '077 379 4567';
    } else if (label == 'Joined Date') {
      fieldValue = '30 Jan, 2023';
    } else if (label == 'Password') {
      fieldValue = '********'; // Display masked password
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

  // Validation functions for email and full name.
  String? _validateEmail(String value) {
    return FormValidators.validateEmail(value);
  }

  String? _validateFullName(String value) {
    return FormValidators.validateFullName(value);
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

    if (error == null) {
      // Data is valid, proceed with the update.
      _authService.updateUser(
        context: context,
        field: widget.field,
        value: updatedValue,
      );
    } else {
      // Show an error message or take appropriate actions.
      showSnackBar(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomProfileAppBar(title: "Edit ${widget.field}"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              onChanged: (value) {
                // Clear the error message when the user starts typing.
                setState(() {
                  _errorText = null;
                });
              },
              decoration: InputDecoration(
                labelText: 'Edit ${widget.field}',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorText: _errorText, // Display the error message if present.
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateUser,
              child: Text('Update ${widget.field}'),
            ),
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

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    final String oldPassword = _oldPasswordController.text;
    final String newPassword = _newPasswordController.text;
    // final user = Provider.of<UserProvider>(context).user;

    if (oldPassword.isNotEmpty && newPassword.isNotEmpty) {
      AuthService.changePassword(
              context: context,
              oldPassword: oldPassword,
              newPassword: newPassword,
              userId: '10')
          .then((success) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomProfileAppBar(title: "Change Password"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Old Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
