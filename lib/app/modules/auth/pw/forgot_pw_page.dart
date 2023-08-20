import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_page.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';
import 'package:poraki/app/util/alerta.dart';

class ForgotPwPage extends StatelessWidget {
  final TextEditingController txtEmail = TextEditingController();
  late FirebaseFirestore? fbInstance;
  final FirebaseAuth? auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Ops, esqueci minha senha",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF116530),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value!.length < 5) {
                  return "Esse e-mail parece curto demais";
                } else if (!value.contains("@")) {
                  return "Esse e-mail está meio estranho, não?";
                }
                return null;
              },
              controller: txtEmail,
              keyboardType: TextInputType.emailAddress,
              autofocus: false, // true,
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () async {
                  await auth!
                      .sendPasswordResetEmail(email: txtEmail.text.trim());

                  // Alerta(context, 'Redefinição de senha enviada por e-mail');

                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  // Get.toNamed(AppRoutes.login);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF116530),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                child: Text("Enviar"),
              ),
            ),
            // ButtonsFooterLogin(controller: controller)
          ],
        ),
      ),
        ));
  }
}
