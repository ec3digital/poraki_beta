import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

Alerta(BuildContext context, String msg) {
  // configura o button
  Widget okButton = ElevatedButton(
    child: Text("OK"),
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Color(0xFF116530),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Color(0xFFA3EBB1))),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Alerta"),
    content: Text(msg),
    contentTextStyle: TextStyle(color: AppColors.primaryDark),
    backgroundColor: AppColors.secondaryBackground,
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
