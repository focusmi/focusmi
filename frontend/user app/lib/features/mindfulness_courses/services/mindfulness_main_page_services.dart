import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/models/mindfulnesscourses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MindFMainPageServices {
  static Future getFeaturedContent() async {
    List<MindfulnessCourse> course = [
      MindfulnessCourse(
          course_id: 1,
          author: 'Miguel Simpson',
          image: 'bg1.png',
          subtitle: 'Be Yourself',
          user_category: 'common',
          objective_type: 'Personality',
          course_type: 'Free',
          remarks: '',
          likes: 0,
          decription: 'Unveil true yourself to make each minute to be happy',
          title: 'Unveil Personality Now')
    ];
    return course;
  }

  static Future getMeditationContent() async {
    List<MindfulnessCourse> course = [
      MindfulnessCourse(
          course_id: 2,
          author: 'Norman Osborn',
          image: 'bird.png',
          subtitle: 'Be the feather',
          user_category: 'common',
          objective_type: 'Meditation',
          course_type: 'Free',
          remarks: '',
          likes: 1,
          decription: 'Relax your mind, free your mind like a feather in wind',
          title: 'Free It Now')
    ];
    return course;
  }

  static Future getOnGoingContent() async {
    List<MindfulnessCourse> course = [
      MindfulnessCourse(
          course_id: 2,
          author: 'Norman Osborn',
          image: 'bird.png',
          subtitle: 'Be the feather',
          user_category: 'common',
          objective_type: 'Meditation',
          course_type: 'Free',
          remarks: '',
          likes: 1,
          decription: 'Relax your mind, free your mind like a feather in wind',
          title: 'Free It Now')
    ];
    return course;
  }

  static Future getForYouContent() async {
    List<MindfulnessCourse> course = [
      MindfulnessCourse(
          course_id: 2,
          author: 'Norman Osborn',
          image: 'bird.png',
          subtitle: 'Be the feather',
          user_category: 'common',
          objective_type: 'Meditation',
          course_type: 'Free',
          remarks: '',
          likes: 1,
          decription: 'Relax your mind, free your mind like a feather in wind',
          title: 'Free It Now')
    ];
    return course;
  }

  static Future getTherapists() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-therapist'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer ' + token.toString()
        },
      );
      return res;
    } catch (e) {
      print(e);
    }
  }
}
