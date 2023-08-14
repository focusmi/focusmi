import 'package:page_transition/page_transition.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/auth/services/auth_service.dart';
import 'package:therapist_app/features/profile/screen/profile_detail_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:therapist_app/features/profile/service/profile_service.dart';
import 'package:therapist_app/features/schedule/screen/set_time_schedule_screen.dart';

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
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 90,
            backgroundColor: _showFlexibleSpaceTitle
                ? GlobalVariables.primaryText
                : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _showFlexibleSpaceTitle ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 5),
            sliver: SliverToBoxAdapter(
              child: Body(),
            ),
          )
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
          const SizedBox(height: 30),
          ProfileMenu(
            text: "My Account",
            icon: Icons.people_alt_sharp,
            press: () {
              Navigator.push(
                context,
                PageTransition(type: PageTransitionType.leftToRight, child: ProfileDetailsPage()),
              );
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: Icons.notifications,
            press: () {},
          ),
          ProfileMenu(
            text: "Set Appointments Time",
            icon: Icons.timelapse,
            press: () {
              Navigator.push(
                context,
                PageTransition(type: PageTransitionType.leftToRight, child: SetTimeScheduleScreen()),
              );
            },
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
          const SizedBox(height: 20.0),
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
          foregroundColor: Color.fromARGB(172, 0, 0, 0),
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
            const Icon(
              Icons.arrow_forward_ios,
              color: GlobalVariables.primaryText,
            ),
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
  String? _profilePictureUrl;

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
  }

  Future<void> _loadProfilePicture() async {
    final profilePictureUrl =
        await ProfileService.loadProfilePictureUrl(context);
    if (profilePictureUrl != null) {
      setState(() {
        _profilePictureUrl = profilePictureUrl;
      });
    }
  }

  Future<void> _uploadProfilePicture(File imageFile) async {
    bool uploadSuccess =
        await ProfileService.uploadProfilePicture(context, imageFile);
    if (uploadSuccess) {
      // Reload the profile picture after a successful upload
      _loadProfilePicture();
      print('Profile picture uploaded successfully');
    } else {
      print('Failed to upload profile picture');
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.2,
        maxChildSize: 0.2,
        minChildSize: 0.1,
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
                ? FileImage(_selectedImage!)
                : (_profilePictureUrl != null
                    // ? NetworkImage(_profilePictureUrl!)
                    ?const AssetImage("assets/images/doctor1.jpg")
                    : const AssetImage("assets/images/doctor1.jpg")
                        as ImageProvider<Object>),
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
                  backgroundColor: GlobalVariables.greyBackgroundColor,
                ),
                onPressed: () {
                  _showSelectPhotoOptions(context);
                },
                child: const Icon(Icons.edit,
                    color: GlobalVariables.greyTextColor),
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
          const Center(
            child: Text(
              'Edit Profile Picture',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: GlobalVariables.primaryText,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SelectPhoto(
                  onTap: () => _pickImage(ImageSource.gallery),
                  icon: Icons.image,
                  textLabel: 'Gallery',
                ),
                // const SizedBox(height: 10),
                const SizedBox(width: 10),
                SelectPhoto(
                  onTap: () => _pickImage(ImageSource.camera),
                  icon: Icons.camera,
                  textLabel: 'Camera',
                ),
              ],
            ),
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
        elevation: 5,
        shape: const StadiumBorder(),
        backgroundColor: GlobalVariables.primaryText,
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
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              textLabel,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            )
          ],
        ),
      ),
    );
  }
}
