// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/mindfulness_courses/widgets/audio_player.dart';
import 'package:focusmi/models/course_level.dart';
import 'package:focusmi/models/mindfulnesscourses.dart';

class CourseMediaPlayer extends StatefulWidget {
  MindfulnessCourseLevel level;
  MindfulnessCourse course;
  CourseMediaPlayer({
    Key? key,
    required this.level,
    required this.course,
  }) : super(key: key);
  static const String routeName = '/course_media_player';

  @override
  State<CourseMediaPlayer> createState() => _CourseMediaPlayerState();
}

class _CourseMediaPlayerState extends State<CourseMediaPlayer> {
  @override
  Widget build(BuildContext context) {
    return AudioPlayera(
        musicUrl: '$uri/api/assets/image/mind-course/${widget.level.content_location}',
        imageUrl: '$uri/api/assets/image/mindf-course/${widget.course.image}');
  }
}
