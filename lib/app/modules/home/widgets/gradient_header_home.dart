import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class GradientHeaderHome extends StatelessWidget {
  final Widget child;
  const GradientHeaderHome({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    return Container(
      decoration: BoxDecoration(
        color: _loginController.colorFromHex(_loginController.backDark)
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backLight').first.coreValor.toString()),
        //     _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
        //   ],
        // ),
      ),
      child: child,
    );
  }
}
