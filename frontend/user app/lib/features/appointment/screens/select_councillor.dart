import 'package:flutter/material.dart';
import 'package:focusmi/features/appointment/screens/councillor_details.dart';
import 'package:focusmi/features/appointment/services/appointment_service.dart';

import '../../../constants/global_variables.dart';

class CounselorsListWidgetWidget extends StatefulWidget {
  const CounselorsListWidgetWidget({Key? key}) : super(key: key);
  static const String routeName = '/select_councillor';

  @override
  _CounselorsListWidgetWidgetState createState() =>
      _CounselorsListWidgetWidgetState();
}

class _CounselorsListWidgetWidgetState
    extends State<CounselorsListWidgetWidget> {
  late List<dynamic> councillorData; // To store the fetched data

  @override
  void initState() {
    super.initState();
    fetchCouncillorData();
    councillorData = [];
  }

  Future<void> fetchCouncillorData() async {
    try {
      final data = await AppointmentService.getCouncillorList();
      setState(() {
        councillorData = data;
        print(councillorData);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF83DE70),
        title: Text(
          'Counsellors',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: councillorData.length,
            itemBuilder: (context, index) {
              var councillor = councillorData[index];
              return CouncillorCard(
                imageUrl: '$uri/' + councillor['profile_image'] ?? '',
                username: councillor['full_name'] ?? '',
                title: councillor['title'] ?? '',
                email: councillor['email'] ?? '',
                about: councillor['about'] ?? '',
                exp: councillor['years_of_experience'] ?? '',
                tot_clients: councillor['tot_clients'] ?? 0,
                user_id: councillor['user_id'] ?? 1,
              );
            },
          ),
        ),
      ),
    );
  }
}

class CouncillorCard extends StatelessWidget {
  final String? imageUrl;
  final String? username;
  final String? title;
  final String? email;
  final String? about;
  final String? exp;
  final int? tot_clients;
  final int? user_id;

  CouncillorCard({
    Key? key,
    this.imageUrl,
    this.username,
    this.title,
    this.about,
    this.email,
    this.exp,
    this.tot_clients,
    this.user_id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(imageUrl ?? ''),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        title ?? '',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Experience: ${exp ?? 1} years',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Clients: ${tot_clients??0}+',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsWidget(
                            name: username ?? '',
                            email: email ?? '',
                            title: title ?? '',
                            about: about ?? '',
                            experience: exp ?? '',
                            image: imageUrl ?? '',
                            totcustomer: tot_clients ?? 0,
                            userId: user_id ?? 0,
                          ),
                        ),
                      );
                    },
                    child: Text('Details'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF83DE70),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
