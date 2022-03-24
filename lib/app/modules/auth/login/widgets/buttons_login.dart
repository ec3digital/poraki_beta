import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../../sign_up/sign_up_page.dart';
import '../login_controller.dart';
import 'package:poraki/app/theme/app_theme.dart';

class ButtonsFooterLogin extends StatelessWidget {
  const ButtonsFooterLogin({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            "Esqueceu a senha?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        GetBuilder<LoginController>(builder: (_) {
          return Row(
            children: [
              Checkbox(
                value: controller.obscurePassword,
                onChanged: (newValue) {
                  controller.changeCheckBox(newValue!);
                },
                activeColor: Colors.blue,
              ),
              Text(
                "Mostrar senha",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          );
        }),
        ElevatedButton(
          onPressed: () {
            controller.doLogin(context);
          },
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                AppColors.primaryColorButton
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(
            color: Colors.black,
          ),
        ),
        Text(
          "Ainda não tem uma conta?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.signUp);
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.secondaryColorButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text("Cadastre-se"),
          ),
        ),
      ],
    );
  }
}
