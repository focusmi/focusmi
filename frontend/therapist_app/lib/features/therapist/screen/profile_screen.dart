import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/auth/services/auth_service.dart';
import 'package:therapist_app/features/therapist/screen/profile_detail_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../profile_service/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ignore: prefer_final_fields
  ScrollController _scrollController = ScrollController();
  bool _showFlexibleSpaceTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateFlexibleSpaceTitleVisibility);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateFlexibleSpaceTitleVisibility);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateFlexibleSpaceTitleVisibility() {
    setState(() {
      _showFlexibleSpaceTitle = _scrollController.hasClients &&
          _scrollController.offset >= (kToolbarHeight - kToolbarHeight / 4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          CustomAppBar(
            title: "Settings",
            scrollController: _scrollController, // Pass the scroll controller
            showFlexibleSpaceTitle: _showFlexibleSpaceTitle, // Pass the showFlexibleSpaceTitle value
          ),
          const SliverFillRemaining(
            child: Body(),
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: Icons.people_alt_sharp,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileDetailsPage(),
                ),
              );
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: Icons.notifications,
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: Icons.settings,
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: Icons.help,
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: Icons.logout,
            press: () {
              AuthService().logOut(context);
            },
          ),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: GlobalVariables.greyTextColor,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? _selectedImage;

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.28,
        maxChildSize: 0.4,
        minChildSize: 0.28,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: SelectPhotoOptionsScreen(
              onImageSelected: (image) {
                setState(() {
                  _selectedImage = image;
                });
                _uploadProfilePicture(image);
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _uploadProfilePicture(File imageFile) async {
    bool uploadSuccess = await ProfileService.uploadProfilePicture(imageFile);
    if (uploadSuccess) {
      print('Profile picture uploaded successfully');
    } else {
      print('Failed to upload profile picture');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: _selectedImage != null
                ? FileImage(_selectedImage!) as ImageProvider<Object>
                : AssetImage("assets/images/doctor1.jpg"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: GlobalVariables.greyBackgroundCOlor,
                ),
                onPressed: () {
                  _showSelectPhotoOptions(context);
                },
                child: const Icon(Icons.edit,color:GlobalVariables.greyTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectPhotoOptionsScreen extends StatelessWidget {
  const SelectPhotoOptionsScreen({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);

  final Function(File) onImageSelected;

  void _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final selectedImage = File(pickedImage.path);
      onImageSelected(selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SelectPhoto(
            onTap: () => _pickImage(ImageSource.gallery),
            icon: Icons.image,
            textLabel: 'Browse Gallery',
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'OR',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          SelectPhoto(
            onTap: () => _pickImage(ImageSource.camera),
            icon: Icons.camera_alt_outlined,
            textLabel: 'Use a Camera',
          ),
        ],
      ),
    );
  }
}

class SelectPhoto extends StatelessWidget {
  final String textLabel;
  final IconData icon;

  final void Function()? onTap;

  const SelectPhoto({
    Key? key,
    required this.textLabel,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        primary: Colors.grey.shade200,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              textLabel,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
