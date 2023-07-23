import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import '../../auth/services/auth_service.dart';
import '../profile_service/profile_service.dart';

class ProfileDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    print(user.token);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileField(
                label: 'Full Name',
                value: user.name,
                onTap: () {
                  navigateToEditPage(context, 'Full Name', user.name);
                },
              ),
              SizedBox(height: 16.0),
              ProfileField(
                label: 'Email',
                value: user.email,
                onTap: () {
                  navigateToEditPage(context, 'Email', user.email);
                },
              ),
              SizedBox(height: 16.0),
              ProfileField(
                label: 'Address',
                value: 'address',
                onTap: () {
                  navigateToEditPage(context, 'Address', '');
                },
              ),
              SizedBox(height: 16.0),
              ProfileField(
                label: 'Password',
                value: '********',
                onTap: () {
                  navigateToChangePasswordPage(context);
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

  const ProfileField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    String fieldValue;
    if (label == 'Full Name') {
      fieldValue = user.name;
    } else if (label == 'Email') {
      fieldValue = user.email;
      // } else if (label == 'Address') {
      //   fieldValue = user.address;
    } else if (label == 'Password') {
      fieldValue = '********'; // Display masked password
    } else {
      fieldValue = ''; // Default value if field label doesn't match
    }

    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.grey[200], // Gray background color
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      fieldValue,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black, // Black value text color
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
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

  void _updateUser() {
    final updatedValue = _textEditingController.text;
    _authService.updateUser(
      context: context,
      field: widget.field,
      value: updatedValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.field}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              onChanged: (value) {
                // No need to use setState here as we are directly updating the controller's value
              },
              decoration: InputDecoration(
                labelText: 'Edit ${widget.field}',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
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
      appBar: AppBar(
        title: Text('Change Password'),
      ),
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
            SizedBox(height: 16.0),
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
