import 'package:flutter/material.dart';
import 'package:focusmi/features/appointment/screens/add_appointment.dart';

class DetailsWidget extends StatelessWidget {
  final String name;
  final String email;
  final String image;
  final String about;
  final String title;
  final String experience;
  final int totcustomer;
  final int userId;

  DetailsWidget({
    Key? key,
    required this.name,
    required this.image,
    required this.email,
    required this.about,
    required this.title,
    required this.experience,
    required this.totcustomer,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF83DE70),
        title: Text(
          'Counsellor Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [const Color(0xFF83DE70), const Color(0xFF2E7D32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(image),
              ),
            ),
            SizedBox(height: 16),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconText(icon: Icons.people, text: '$totcustomer+ Patients'),
                SizedBox(width: 20),
                IconText(
                    icon: Icons.explicit, text: '$experience Yrs Experience'),
              ],
            ),
            SizedBox(height: 16),
            SectionHeading(text: 'About'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                about,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            SectionHeading(text: 'Contact'),
            IconText(icon: Icons.email_rounded, text: email),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentPage(userId: userId),
                  ),
                );
              },
              child: Text('Book Appointment'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF83DE70),
                textStyle: TextStyle(fontSize: 18),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  IconText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 24,
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String text;

  SectionHeading({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
