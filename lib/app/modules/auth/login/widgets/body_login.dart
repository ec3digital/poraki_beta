import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_controller.dart';
import 'buttons_login.dart';
import 'form_login.dart';
import 'gradient_top_login.dart';
import 'header_login.dart';

class BodyLogin extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GradientTopLogin(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderLogin(),
            FormLogin(),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            ButtonsFooterLogin(controller: controller)
          ],
        ),
      ),
    );
  }
}