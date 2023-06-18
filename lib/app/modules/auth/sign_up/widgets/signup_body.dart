import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';
import 'package:poraki/app/util/alerta.dart';
import '../sign_up_controller.dart';
import 'signup_form.dart';

class SignupBody extends StatefulWidget {
  final SignUpController controller;

  SignupBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
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
          colors: [AppColors.primaryBackground, AppColors.secondaryBackground],
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
                color: Colors.blueGrey,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            FormSignup(controller: widget.controller),
            MaterialButton(
              onPressed: () async {
                var ret = await widget.controller.doSignUp();
                if (ret == 'OK') {
                  Get.toNamed(AppRoutes.locals);
                } else {
                  Alerta(context, ret.toString());
                }
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
