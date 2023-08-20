import 'package:flutter/material.dart';
import '../login_controller.dart';

class FormLogin extends StatelessWidget {
  FormLogin({Key? key}) : super(key: key);
  final bool _obscurePassword = true;
  final LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: controller.formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.length < 5) {
                return "Esse e-mail parece curto demais";
              } else if (!value.contains("@")) {
                return "Esse e-mail está meio estranho, não?";
              }
              return null;
            },
            controller: controller.mailInputController,
            keyboardType: TextInputType.emailAddress,
            autofocus:  false, // true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "E-mail",
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              prefixIcon: Icon(
                Icons.mail_outline,
                color: Colors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value!.length < 6) {
                return "A senha deve ter pelo menos 6 caracteres";
              }
              return null;
            },
            obscureText: _obscurePassword,
            controller: controller.passwordInputController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Senha",
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              prefixIcon: Icon(
                Icons.vpn_key_sharp,
                color: Colors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
