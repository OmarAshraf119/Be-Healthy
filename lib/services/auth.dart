import 'package:be_healthy/nutritionist/Account.dart';
import 'package:be_healthy/services/database.dart';
class AuthService {

  Account _accountFromJson(var result){
    return result != null ? Account.fromJson(result) : null;
  }
  // Sign in

  Future signIn(String email, String password) async{

    var result = await DatabaseService().SignIn(email, password);
    return _accountFromJson(result);
  }

}