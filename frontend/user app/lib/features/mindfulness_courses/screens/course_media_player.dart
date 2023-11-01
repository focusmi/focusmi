// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/mindfulness_courses/screens/course_content.dart';
import 'package:focusmi/features/mindfulness_courses/widgets/audio_player.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/course_level.dart';
import 'package:focusmi/models/mindfulnesscourses.dart';
import 'package:focusmi/widgets/texts.dart';

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
  // Widget build(BuildContext context) {
  //   return AudioPlayera(
  //       musicUrl: '$uri/api/assets/image/mind-course/${widget.level.content_location}',
  //       imageUrl: '$uri/api/assets/image/mindf-course/${widget.course.image}');
    
//}
Widget build(BuildContext context) {
    LayOut layout = LayOut();
    return layout.mainLayoutPage(SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // child: Image.network(
              //   '$uri/api/assets/image/mind-course/${widget.course?.image}',
              //   width: MediaQuery.of(context).size.width,
              //   height: 250,
              //   fit: BoxFit.cover,
              // ),
              child: ClipPath(
                clipper: ConvexBottomClipper(),
                child: Image.network(
                  '$uri/api/assets/image/mind-course/${widget.course?.image}',
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  CustomText.titleText(widget.level.level_name??''),
                  SizedBox(height: 10,),
                  Text(widget.level.level_description??'',style: TextStyle(
                    color: GlobalVariables.greyFontColor
                  ),),
                ],
              ),
            ),
            Container(
              height: 300,
              child:AudioPlayera(level: widget.level,
        musicUrl: '$uri/api/assets/image/mind-course/${widget.level.content_location}',
        imageUrl: '$uri/api/assets/image/mindf-course/${widget.course.image}')
        
          
            )
          
            
          ],
        ),
      ),
    ));
    
    
  }
}


// Widget build(BuildContext context) {
//     LayOut layout = LayOut();
//     return layout.mainLayoutPage(SingleChildScrollView(
//       child: Container(
//         child: Column(
//           children: [
//             Container(
//               // child: Image.network(
//               //   '$uri/api/assets/image/mind-course/${widget.course?.image}',
//               //   width: MediaQuery.of(context).size.width,
//               //   height: 250,
//               //   fit: BoxFit.cover,
//               // ),
//               child: ClipPath(
//                 clipper: ConvexBottomClipper(),
//                 child: Image.network(
//                   '$uri/api/assets/image/mind-course/${widget.course?.image}',
//                   width: MediaQuery.of(context).size.width,
//                   height: 300,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Container(
//             child:
//                 player()
//             )
          
            
//           ],
//         ),
//       ),
//     ));
    
//   }
// }

