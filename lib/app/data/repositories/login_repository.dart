import 'package:get/get_connect.dart';
import '../models/login_model.dart';

class LoginRepository extends GetConnect {
  Future<LoginModel> userLogin(LoginModel credential) async {
    final response = await post(" ", credential.toJson());
    if (response.hasError) {
      throw "Erro ao fazer o login";
    }
    return LoginModel.fromMap(response.body);
  }

  // Future<LoginModel> _getSavedUser() async {

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String jsonUser = prefs.getString(PreferencesKeys.activeUser);
  //     print(jsonUser);

  //   Map<String, dynamic> mapUser = json.decode(jsonUser);
  //   LoginModel user = LoginModel.fromJson(mapUser);
  //     return user;
  // }

}
