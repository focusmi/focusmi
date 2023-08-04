import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  final int appID = int.parse(dotenv.get('ZEGO_APP_ID',fallback:""));
  final String appSign = dotenv.get('ZEGO_APP_SIGN',fallback:"");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: appID,
        appSign: appSign,
        userID: userId,
        userName: userName,
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
