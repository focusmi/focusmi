import 'package:focusmi/models/chat_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:focusmi/constants/global_variables.dart';

class ChatRoomServices {

  static Future getChatMessage(groupid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/get-chat-message/$groupid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {}
  
  }

  static Future createChat(groupid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.get(
          Uri.parse('$uri/api/create-chat/$groupid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          });
      return res;
    } catch (e) {}
  
  }

  static Future createChatMessage(ChatMessage message) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token');
      http.Response res = await http.post(
          Uri.parse('$uri/api/add-chat-message'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Bearer ' + token.toString()
          },
          body: message.toJson()
          );
      return res;
    } catch (e) {}
  
  }

}
