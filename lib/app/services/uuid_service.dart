import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class uuidService {

  Future<String> getRandomUUID() async {
    final LoginController _loginController = Get.find();
    await _loginController.getFBParams();
    var response = await http.get(Uri.parse(_loginController.uuidSvcUrl));

    return response.body.toString();
  }
}
