import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/mindfulness_courses/widgets/audio_player.dart';

class CourseMediaPlayer extends StatefulWidget {
  const CourseMediaPlayer({super.key});
  static const String routeName = '/course_media_player';

  @override
  State<CourseMediaPlayer> createState() => _CourseMediaPlayerState();
}

class _CourseMediaPlayerState extends State<CourseMediaPlayer> {
  @override
  Widget build(BuildContext context) {
    return AudioPlayera(
        musicUrl: '$uri/api/assets/audio/mind-course/1.mp3',
        imageUrl: '$uri/api/assets/image/user-profs/team.png');
  }
}
