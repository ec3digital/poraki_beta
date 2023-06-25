import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PwController extends GetxController {
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  bool showPassword = false;
  // final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();

    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

  }

  Future<void> atualizaPw() async {
    await auth.currentUser!.updatePassword(txtPassword.text.trim());
  }

  void changeShowPassword(bool newValue) {
    showPassword = newValue;
    update();
  }

}
