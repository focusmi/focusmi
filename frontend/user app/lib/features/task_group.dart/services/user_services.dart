import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:focusmi/constants/global_variables.dart';


class UserService{



  static Future getUser(email)async{
      SharedPreferences prefs =await SharedPreferences.getInstance();
      var token = prefs.getString('auth-token'); 
      http.Response members = await http.get(Uri.parse('$uri/api/search-group-member?search=$email'), headers:<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization':'Bearer '+token.toString()
      });
      print("Dfdfd");
      print(members.body);
      return members;
  }


}
