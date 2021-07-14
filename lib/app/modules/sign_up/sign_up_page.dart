import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/sign_up/sign_up_controller.dart';
import 'package:poraki/app/modules/sign_up/signup_widgets/signup_body.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController _controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupBody(controller: _controller),
    );
  }
}
