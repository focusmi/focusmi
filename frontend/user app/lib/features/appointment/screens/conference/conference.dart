import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;
  final String userName;
  final String userId;

  VideoConferencePage({
    Key? key,
    required this.conferenceID,
    required this.userName,
    required this.userId,
  }) : super(key: key);

  final int appID = 1347172117;
  final String appSign =
      'd1e57044d4819b87632f6642c55440a2812b8d9211d5ccc6c8cd856e8e874886';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: appID,
        appSign: appSign,
        userID: userId,
        userName: userName,
        conferenceID: conferenceID,
        // config: ZegoUIKitPrebuiltVideoConferenceConfig(),
        config: ZegoUIKitPrebuiltVideoConferenceConfig(
          avatarBuilder: (BuildContext context, Size size, ZegoUIKitUser? user,
              Map extraInfo) {
            return user != null
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/doctor1.jpg")),
                    ),
                  )
                : const SizedBox();
          },
          audioVideoViewConfig: ZegoPrebuiltAudioVideoViewConfig(
            foregroundBuilder: (BuildContext context, Size size,
                ZegoUIKitUser? user, Map extraInfo) {
              return user != null
                  ? Positioned(
                      bottom: 5,
                      left: 5,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/images/doctor1.jpg")),
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
          turnOnCameraWhenJoining: false,
          turnOnMicrophoneWhenJoining: false,
          useSpeakerWhenJoining: true,
          onLeaveConfirmation: (BuildContext context) async {
            return await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: GlobalVariables.backgroundColor,
                  title: const Text("Leave the conference",
                      style: TextStyle(color: Colors.white70)),
                  content: const Text("Are you sure to leave the conference?",
                      style: TextStyle(color: Colors.white70)),
                  actions: [
                    ElevatedButton(
                      child: const Text("Cancel",
                          style:
                              TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Change this to your desired color
                      ),
                      child: const Text("Exit",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255))),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
