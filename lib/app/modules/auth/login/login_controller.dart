import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/login_model.dart';
import '../../../data/repositories/login_repository.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final TextEditingController mailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final LoginRepository loginRepository = LoginRepository();

  get obscurePassword => _obscurePassword;

  bool _obscurePassword = false;

  void changeCheckBox(bool newObscurePassword) {
    _obscurePassword = newObscurePassword;
    update();
  }

  void doLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      loginRepository.userLogin(
        LoginModel(
          mail: mailInputController.text,
          password: passwordInputController.text,
          keepOn: false,
          name: '',
        ),
      );
      Get.toNamed(AppRoutes.offer);
    } else {
      print("invalido");
    }
  }
}
