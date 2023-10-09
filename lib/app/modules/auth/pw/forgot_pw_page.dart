import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poraki/app/modules/auth/login/login_page.dart';
import 'package:poraki/app/theme/app_theme.dart';

class ForgotPwPage extends StatefulWidget {
  @override
  State<ForgotPwPage> createState() => _ForgotPwPageState();
}

class _ForgotPwPageState extends State<ForgotPwPage> {
  final TextEditingController txtEmail = TextEditingController();
  final FirebaseAuth? auth = FirebaseAuth.instance;
  final _formFgtpwKey = GlobalKey<FormState>();
  late FirebaseFirestore? fbInstance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
      //child: SingleChildScrollView(
        child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formFgtpwKey,
            child: ListView(children: [
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
                validator: (valueEmail) {
                  RegExp regex = new RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                  if (valueEmail!.isEmpty || !regex.hasMatch(valueEmail))
                    return 'Favor informar um endereço de e-mail correto';
                  else
                    return null;
                },
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
                autofillHints: [AutofillHints.email],
                autofocus: true,
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
                    if (_formFgtpwKey.currentState!.validate()) {
                      await auth!
                          .sendPasswordResetEmail(email: txtEmail.text.trim());

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Mensagem de e-mail enviada com instruções para o endereço de e-mail informado'),
                          action: SnackBarAction(label: 'OK', onPressed: () {}),
                        ),
                      );

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      // Get.toNamed(AppRoutes.login);
                    }
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
            ])),
     // ),
    ));
  }
}
