import 'dart:io';
import 'package:http/http.dart' as http;


class ProfileService {
  static Future<bool> uploadProfilePicture(File imageFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('your_upload_url'));
      request.files.add(
          await http.MultipartFile.fromPath('profile_picture', imageFile.path));
      var response = await request.send();
      return response.statusCode == 200;
    } catch (error) {
      print('Error uploading profile picture: $error');
      return false;
    }
  }

}
