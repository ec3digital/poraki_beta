import 'package:flutter/material.dart';
import 'package:poraki/app/theme/app_theme.dart';

import '../sign_up_controller.dart';
import 'signup_form.dart';

class SignupBody extends StatelessWidget {
  final SignUpController controller;

  SignupBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 50,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryBackground,
            AppColors.secondaryBackground
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Cadastro",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            FormSignup(controller: controller),
            MaterialButton(
              onPressed: () {
                controller.doSignUp();
              },
              child: Text("Casdastrar"),
              color: AppColors.secondaryColorButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
