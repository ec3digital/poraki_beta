import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  //show error dialog
  static void showAlert({String title = 'Alerta', String? description = 'Ops, algo deu errado dessa vez'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline4,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.headline6,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Text('Ok'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // //show toast
  // //show snack bar
  // //show loading
  // static void showLoading([String? message]) {
  //   Get.dialog(
  //     Dialog(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             CircularProgressIndicator(),
  //             SizedBox(height: 8),
  //             Text(message ?? 'Carregando...'),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // //hide loading
  // static void hideLoading(BuildContext context) {
  //   Navigator.pop(context);
  //   // if (Get.isDialogOpen!)
  //   //   Get.back();
  // }

}