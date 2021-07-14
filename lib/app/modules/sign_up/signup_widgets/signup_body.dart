import 'package:flutter/material.dart';

import 'package:poraki/app/modules/sign_up/sign_up_controller.dart';
import 'package:poraki/app/theme/custom_colors.dart';

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
            CustomColors().getGradientSecondaryColor(),
            CustomColors().getGradientMainColor(),
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
              color: CustomColors().getActiveSecondaryButton(),
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
