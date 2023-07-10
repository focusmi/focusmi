
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/models/user.dart';
import 'package:http/http.dart' as http;
class AuthService{
  //signup 
  void signInUser({
    required String email,
    required String password
  }) async {
    try{
     
      User user = User(
        id: '',
        username: '',
        password: password,
        email: email,
        token: ''
      );
      
      http.Response res=await http.post(Uri.parse('$uri/api/signin'), body: user.toJson(), headers:<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
    }catch(e){

    }
  }
  
  void createUser({
    required String email,
    required String username,
    required String password
  }) async {
    try{
      User user = User(email: email, username: username, password: password, id: '',token:' ');
      http.Response res = await http.post(Uri.parse('$uri/api/signup'), body: user.toJson(), headers:<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

    }
    catch(e){

    }
  }
}