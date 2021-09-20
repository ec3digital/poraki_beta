import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sign_up_controller.dart';
import 'widgets/signup_body.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController _controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupBody(controller: _controller),
    );
  }
}
