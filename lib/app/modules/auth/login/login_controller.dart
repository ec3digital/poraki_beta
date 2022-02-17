import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/services/hive/hive_poraki_user_service.dart';

import '../../../data/models/login_model.dart';
import '../../../data/repositories/login_repository.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final TextEditingController mailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final LoginRepository loginRepository = LoginRepository();

  //TODO: salvar dados de login em sharedprefs e cep
  //TODO: salvar cores no sharedprefs em outro controller baseado no firebase
  get obscurePassword => _obscurePassword;

  bool _obscurePassword = false;

  void changeCheckBox(bool newObscurePassword) {
    _obscurePassword = newObscurePassword;
    update();
  }

  // valida o login
  void doLogin(BuildContext context) async {
    // if (formKey.currentState!.validate()) {
    //   loginRepository.userLogin(
    //     LoginModel(
    //       mail: mailInputController.text.removeAllWhitespace,
    //       password: passwordInputController.text.removeAllWhitespace,
    //       keepOn: false,
    //       name: '',
    //     ),
    //   );

      // salva usuario no hive, cria instancia do hive e abre a box
      new hivePorakiUserService().SetUserEmail(mailInputController.text.removeAllWhitespace);

      // redireciona para a home de ofertas
      Get.toNamed(AppRoutes.offer);
    // } else {
    //   print("invalido");
    // }
  }
}
