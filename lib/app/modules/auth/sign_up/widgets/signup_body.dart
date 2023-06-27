import 'package:flutter/material.dart';
import 'package:poraki/app/theme/app_theme.dart';
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
        horizontal: 20,
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
            Padding(padding: EdgeInsets.only(bottom: 4)),
            FormSignup(controller: widget.controller),

          ],
        ),
      ),
    );
  }
}
